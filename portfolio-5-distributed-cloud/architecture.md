# Distributed and Cloud Database Architecture

## 1. CAP Theorem
The CAP theorem states that a distributed system can guarantee only two of three properties: Consistency, Availability, and Partition Tolerance.

| Property | Meaning |
|----------|---------|
| Consistency | Every read sees the latest write |
| Availability | Every request gets a response |
| Partition Tolerance | Works despite network failures |

**Library choice:** Availability for reads (catalogue search), Consistency for writes (borrowing).

## 2. Primary-Replica Replication
The primary accepts writes on port 5433. The replica streams the WAL on port 5434. This provides high availability and read scaling.

## 3. Sharding
Shard by library_branch_id for multi-campus scale. Only needed at extreme scale.

## 4. Cloud Deployment
- AWS RDS for PostgreSQL
- Azure Database for PostgreSQL
- Google Cloud SQL
Multi-AZ + Read Replicas + Cross-Region for HA and DR.

## 5. Conclusion
Portfolio 5 demonstrated a working primary-replica cluster with streaming replication.
