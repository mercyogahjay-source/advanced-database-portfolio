# MIT 8103 Advanced Database Systems Portfolio

**Student Name:** MERCY OGAH
**Student ID:** 301908494
**Course:** MIT 8103 Advanced Database Systems
**Session:** 2026/2027 First Semester

## Case Study: University Library Management System

A university library that lends books, tracks loans, manages fines,
and maintains a catalogue of books and members.

## Portfolio Status

| # | Portfolio | Marks | Status |
|---|-----------|-------|--------|
| 1 | Database Design and Modelling | 7 | Done |
| 2 | Query Processing and Optimisation | 7 | Done |
| 3 | Transactions and Concurrency | 7 | Done |
| 4 | NoSQL and Advanced Data Models | 7 | Done |
| 5 | Distributed and Cloud Database Exercise | 6 | Done |
| Final | Documentation and Reflection | 6 | Done |

## Tools Used
VS Code, Docker Desktop, PostgreSQL 15, MongoDB 6.0, Python 3 (pg8000), dbdiagram.io.

## My Reflection on Each Portfolio

### Portfolio 1 — Database Design
I designed a 6-table relational schema (Authors, Members, Books, Loans, Fines, Reviews) in 3NF/BCNF. I added CHECK constraints to enforce business rules and foreign keys to maintain referential integrity. I verified the schema by loading 51 rows of seed data and testing constraint violations.

### Portfolio 2 — Query Optimisation
I wrote 8 complex SQL queries using JOINs, aggregations, and subqueries. I used EXPLAIN ANALYZE to view execution plans. Interestingly, PostgreSQL chose Sequential Scans over my indexes because the tables were small (10 rows). I demonstrated how indexes would be used on larger datasets by forcing them with SET enable_seqscan = OFF.

### Portfolio 3 — Transactions and Concurrency
I demonstrated COMMIT, ROLLBACK, and SAVEPOINT. I also wrote a Python script using pg8000 to simulate two members borrowing the same book simultaneously. Using SELECT ... FOR UPDATE, I proved that row-level locking prevents race conditions (the second user waited and saw 5 copies instead of 6).

### Portfolio 4 — NoSQL
I created a MongoDB collection for book reviews. I embedded book and member data for fast single-query reads and implemented aggregation pipelines (\, \) to calculate average ratings per book. This demonstrated polyglot persistence: SQL for transactions, NoSQL for flexible content.

### Portfolio 5 — Distributed and Cloud
I set up a primary-replica PostgreSQL cluster using Docker. The primary accepted writes while the replica streamed the Write-Ahead Log. I verified replication by inserting a book on the primary and seeing it appear on the replica, and proved the replica was read-only.

## AI Use Declaration

**Tool used:** DeepSeek as a learning aid and reviewer.

**What I used it for:** Understanding database concepts, debugging Docker errors, and reviewing code.

**How I verified it:** Every command was run locally by me. All screenshots are from my own runs. I intentionally broke constraints and tested race conditions to understand the concepts.
