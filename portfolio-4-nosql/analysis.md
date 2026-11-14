# NoSQL Implementation Analysis

## 1. Introduction
MongoDB used for reviews. PostgreSQL remains source of truth for transactions.

## 2. Why NoSQL for Reviews?
- Free-text comments
- Variable fields (tags, reactions)
- Read-heavy
- Schema flexibility

## 3. Document Model
Embedding (book + member inside each review) for single-query reads.

## 4. Implementation
- 5 reviews inserted
- 5 indexes created
- CRUD + aggregation pipelines

## 5. Comparison with SQL

| Task | SQL | MongoDB |
|------|-----|---------|
| Get reviews for book 5 | JOIN 3 tables | Single find |
| Avg rating per book | AVG + GROUP BY | \ + \ |
| Add helpful vote | UPDATE | \ |

## 6. Key Findings
Polyglot persistence: SQL for transactions, NoSQL for content.
