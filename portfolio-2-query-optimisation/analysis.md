# Query Processing and Optimisation Analysis

## 1. Introduction
Analysed 8 SQL queries with EXPLAIN ANALYZE before and after indexing.

## 2. The 8 Queries
| Query | Technique | Purpose |
|-------|-----------|---------|
| Q1 | INNER JOIN | Catalogue with authors |
| Q2 | Multi-JOIN + date math | Overdue report |
| Q3 | LEFT JOIN + GROUP BY | Top borrowers |
| Q4 | HAVING clause | Top-rated books |
| Q5 | Subquery | Unpaid fines |
| Q6 | LEFT JOIN + IS NULL | Unborrowed books |
| Q7 | DATE_TRUNC | Monthly trends |
| Q8 | LEFT JOIN + COUNT | Author productivity |

## 3. Optimisation 1 — Overdue Loans
**Before Index:** PostgreSQL uses a Sequential Scan because the table is small.
**After Index:** We created idx_loans_status. PostgreSQL's planner may still choose a Sequential Scan because reading 10 rows is faster than a B-tree lookup. 
**Forced Index:** By using SET enable_seqscan = OFF, we can prove the index works and the planner uses Index Scan using idx_loans_status.

## 4. Optimisation 2 — Books by Author
Same pattern. The planner ignores the index on a 10-row table. Forced index proves the index is functional.

## 5. Key Findings
1. Small tables -> planner correctly prefers Seq Scan.
2. Cost-based planning is intelligent, not buggy.
3. Forced-index demonstrates the index works.
4. On large tables, indexes are essential.

## 6. Conclusion
Portfolio 2 demonstrated measurement-driven optimisation.
