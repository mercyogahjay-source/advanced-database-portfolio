-- DEMO 1: COMMIT
BEGIN;
INSERT INTO Books (title, isbn, publication_year, author_id, category, total_copies, available_copies)
VALUES ('Transaction Demo', '999-9999999999', 2026, 1, 'Database', 1, 1);
SELECT book_id, title FROM Books WHERE isbn = '999-9999999999';
COMMIT;
SELECT book_id, title FROM Books WHERE isbn = '999-9999999999';

-- DEMO 2: ROLLBACK
BEGIN;
INSERT INTO Books (title, isbn, publication_year, author_id, category, total_copies, available_copies)
VALUES ('Should Be Rolled Back', '888-8888888888', 2026, 1, 'Database', 1, 1);
ROLLBACK;
SELECT book_id, title FROM Books WHERE isbn = '888-8888888888';

-- DEMO 3: SAVEPOINT
BEGIN;
INSERT INTO Books (title, isbn, publication_year, author_id, category, total_copies, available_copies)
VALUES ('Valid Book', '777-7777777777', 2026, 1, 'Database', 1, 1);
SAVEPOINT after_first;
INSERT INTO Books (title, isbn, publication_year, author_id, category, total_copies, available_copies)
VALUES ('Invalid Book', '666-6666666666', 2026, 999, 'Database', 1, 1);
ROLLBACK TO SAVEPOINT after_first;
COMMIT;

-- DEMO 4: SERIALIZABLE isolation
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT book_id, title FROM Books WHERE book_id = 1;
COMMIT;

-- Cleanup
DELETE FROM Books WHERE isbn IN ('999-9999999999', '777-7777777777');
