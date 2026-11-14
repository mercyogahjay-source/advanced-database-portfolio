-- Optimisation 1: Overdue loans
DROP INDEX IF EXISTS idx_loans_status;

EXPLAIN ANALYZE
SELECT l.loan_id, m.first_name, m.last_name, b.title
FROM Loans l
INNER JOIN Members m ON l.member_id = m.member_id
INNER JOIN Books b ON l.book_id = b.book_id
WHERE l.status = 'Overdue';

CREATE INDEX idx_loans_status ON Loans(status);

EXPLAIN ANALYZE
SELECT l.loan_id, m.first_name, m.last_name, b.title
FROM Loans l
INNER JOIN Members m ON l.member_id = m.member_id
INNER JOIN Books b ON l.book_id = b.book_id
WHERE l.status = 'Overdue';

-- Optimisation 2: Books by author
DROP INDEX IF EXISTS idx_books_author_id;

EXPLAIN ANALYZE
SELECT book_id, title FROM Books WHERE author_id = 6;

CREATE INDEX idx_books_author_id ON Books(author_id);

EXPLAIN ANALYZE
SELECT book_id, title FROM Books WHERE author_id = 6;
