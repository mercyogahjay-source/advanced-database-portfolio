# NoSQL Data Model — MongoDB

## 1. Why NoSQL for Reviews?
Reviews are semi-structured, read-heavy, and have variable fields.
MongoDB fits better than PostgreSQL for this workload.

## 2. Document Model

```javascript
{
  _id: ObjectId("..."),
  book: { book_id: 5, title: "Designing Data-Intensive Applications", isbn: "..." },
  member: { member_id: 1, name: "Mercy Ogah", email: "mercy@example.com" },
  rating: 5,
  title: "Essential reading",
  comment: "...",
  tags: ["distributed-systems", "databases"],
  helpful_votes: 12,
  verified_borrow: true,
  created_at: ISODate("2026-10-05T10:30:00Z")
}
*(Save the file with Ctrl+S).*

4. Right-click the **`portfolio-4-nosql`** folder again → **New File**.
5. Name it: **`analysis.md`**
6. Paste this content:

```markdown
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
| Avg rating per book | AVG + GROUP BY | $group + $avg |
| Add helpful vote | UPDATE | $inc |

## 6. Key Findings
Polyglot persistence: SQL for transactions, NoSQL for content.