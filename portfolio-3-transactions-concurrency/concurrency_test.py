"""
Simulates two members borrowing the same book simultaneously.
Demonstrates row-level locking with SELECT ... FOR UPDATE.
Uses pg8000 (pure Python) because psycopg2 DLL is blocked on Windows.
"""
import threading
import time
import pg8000.native


DB_CONFIG = {
    "user": "student",
    "password": "password",
    "host": "localhost",
    "port": 5432,
    "database": "library_db",
}


def borrow_book(member_id, book_id, thread_name):
    print(f"[{thread_name}] Starting borrow for Member {member_id}, Book {book_id}")
    conn = None
    try:
        conn = pg8000.native.Connection(**DB_CONFIG)

        conn.run("BEGIN")
        print(f"[{thread_name}] Acquiring lock on Book {book_id}...")
        result = conn.run(
            "SELECT book_id, available_copies FROM Books WHERE book_id = :bid FOR UPDATE;",
            bid=book_id,
        )

        if not result:
            print(f"[{thread_name}] Book {book_id} not found.")
            conn.run("ROLLBACK")
            return

        current_available = result[0][1]
        print(f"[{thread_name}] Lock acquired. Available copies: {current_available}")

        time.sleep(2)

        if current_available <= 0:
            print(f"[{thread_name}] No copies available - rolling back.")
            conn.run("ROLLBACK")
            return

        conn.run(
            "UPDATE Books SET available_copies = available_copies - 1 WHERE book_id = :bid;",
            bid=book_id,
        )

        conn.run(
            """
            INSERT INTO Loans (book_id, member_id, loan_date, due_date, status)
            VALUES (:bid, :mid, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', 'Active');
            """,
            bid=book_id, mid=member_id,
        )

        conn.run("COMMIT")
        print(f"[{thread_name}] COMMITTED - Member {member_id} borrowed Book {book_id}")

    except Exception as e:
        print(f"[{thread_name}] ERROR: {e}")
        if conn:
            try:
                conn.run("ROLLBACK")
            except Exception:
                pass
    finally:
        if conn:
            conn.close()
        print(f"[{thread_name}] Connection closed.\n")


def main():
    print("=" * 60)
    print("CONCURRENCY TEST: Two members borrowing the same book")
    print("=" * 60)

    BOOK_ID = 5

    t1 = threading.Thread(target=borrow_book, args=(1, BOOK_ID, "Member-1"))
    t2 = threading.Thread(target=borrow_book, args=(2, BOOK_ID, "Member-2"))

    print("Launching both threads simultaneously...\n")
    t1.start()
    t2.start()
    t1.join()
    t2.join()

    print("=" * 60)
    print("CONCURRENCY TEST COMPLETE")
    print("=" * 60)


if __name__ == "__main__":
    main()
