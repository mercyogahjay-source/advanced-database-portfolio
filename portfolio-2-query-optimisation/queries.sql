-- Q1: Books with author names
SELECT b.book_id, b.title, b.category, b.publication_year,
       a.first_name || ' ' || a.last_name AS author_name,
       b.available_copies
FROM Books b
INNER JOIN Authors a ON b.author_id = a.author_id
ORDER BY b.title;

-- Q2: Overdue loans
SELECT l.loan_id,
       m.first_name || ' ' || m.last_name AS member_name,
       m.email,
       b.title AS book_title,
       l.loan_date, l.due_date,
       CURRENT_DATE - l.due_date AS days_overdue
FROM Loans l
INNER JOIN Members m ON l.member_id = m.member_id
INNER JOIN Books b ON l.book_id = b.book_id
WHERE l.status = 'Overdue'
ORDER BY days_overdue DESC;

-- Q3: Top borrowers
SELECT m.member_id,
       m.first_name || ' ' || m.last_name AS member_name,
       COUNT(l.loan_id) AS total_loans
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY total_loans DESC
LIMIT 5;

-- Q4: Top-rated books
SELECT b.book_id, b.title,
       AVG(r.rating)::NUMERIC(3,2) AS avg_rating,
       COUNT(r.review_id) AS review_count
FROM Books b
INNER JOIN Reviews r ON b.book_id = r.book_id
GROUP BY b.book_id, b.title
HAVING AVG(r.rating) >= 4.5
ORDER BY avg_rating DESC;

-- Q5: Members with unpaid fines
SELECT m.member_id,
       m.first_name || ' ' || m.last_name AS member_name,
       m.email, m.status
FROM Members m
WHERE m.member_id IN (
    SELECT DISTINCT member_id FROM Fines WHERE paid_status = 'Unpaid'
);

-- Q6: Books never borrowed
SELECT b.book_id, b.title, b.category
FROM Books b
LEFT JOIN Loans l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL;

-- Q7: Monthly loan stats
SELECT DATE_TRUNC('month', loan_date)::DATE AS loan_month,
       COUNT(*) AS total_loans,
       COUNT(DISTINCT member_id) AS unique_members
FROM Loans
GROUP BY DATE_TRUNC('month', loan_date)
ORDER BY loan_month;

-- Q8: Author productivity
SELECT a.author_id,
       a.first_name || ' ' || a.last_name AS author_name,
       COUNT(b.book_id) AS books_in_library
FROM Authors a
LEFT JOIN Books b ON a.author_id = b.author_id
GROUP BY a.author_id, a.first_name, a.last_name
ORDER BY books_in_library DESC;
