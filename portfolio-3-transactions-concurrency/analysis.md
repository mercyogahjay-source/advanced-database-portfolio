# Transactions and Concurrency Analysis

## 1. ACID Properties
| Property | Meaning |
|----------|---------|
| Atomicity | All operations succeed or none do |
| Consistency | Database moves from one valid state to another |
| Isolation | Concurrent transactions don't interfere |
| Durability | Committed data survives crashes |

## 2. Transaction Demos
- COMMIT: persists changes
- ROLLBACK: aborts changes
- SAVEPOINT: partial rollback

## 3. Isolation Levels
PostgreSQL supports READ UNCOMMITTED, READ COMMITTED (default), REPEATABLE READ, SERIALIZABLE.

## 4. Concurrency Test
Two threads borrow the same book. Without locking, both would read vailable_copies = 6 and decrement to 4 with 2 loans - a race condition.

Using SELECT ... FOR UPDATE, the second thread waits until the first commits. Member-2 reads 5, not 6. Serialization confirmed.

## 5. Note on Environment
psycopg2 was blocked by Windows Application Control (DLL error). Switched to pg8000 (pure Python).
