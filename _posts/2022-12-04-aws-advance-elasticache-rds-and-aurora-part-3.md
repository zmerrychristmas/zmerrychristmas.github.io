---
title: 'AWS Advance: ElastiCache, RDS and Aurora part 3'
categories:
- Fullstack
- Architect
- AWS
tags:
- aurora
- database
---

# Amazon Aurora
- Aurora is a proprietary technology from AWS (not open sourced)
- Postgress and MYSQL are both supported as Aurora DB (that means your drivers will work as if Aurora was a Postgres or MYSQL database)
- Aurora is "AWS cloud optimized" and claims*5x performance improvement* over MySQL on RDS, over *3x the performance* of Postgres on RDS
- Aurora storage automatically grows in increements of 10GB, up to 128 T B.
- Aurora have *15 replicas while MYSQL has 5*, and the replication process is faster (sub 10ms replica lag)
- Failover in Aurora is **instantaneous**. It's HA (**high Avaiability**) native.
- Aurora costs more than RDS** (20% more)** - but is **more efficient**
## Aurora High Availability and read scaling
- **6 copies of your data across 3 AZ**:
    - 4 copies out of 6 needed for writes
    - 3 copies out of 6 need for reads
    - Self healing with peer to peer replication
    - Storage is striped across 100s of volumes
- One Aurora instance takes write (master)
- Automated failover for master in less than 30 seconds
- **Master + up to 15 Aurora** read replicas serve reads
- Support for Cross Region Replication
- Shared storage Volume Replication + self healing + auto expanding
## Aurora DB Cluster
- **Write** endpoint
    - Pointing to the master
- **Reader** Endpoint
    - Connection Load Balancing
## Features of Aurora
- Automatic Failover
- Backup annd Recovery
- Isolation and security
- Industry compliance
- Push-button scaling
- Automated Patching with Zero Downtime
- Advanced Monitoring
- Routine Maintenance
- Backtrack: restore data at anypoint of time without using backups
## Aurora Security
- Similar to RDS because uses **the same engies**
- Encryption at rest using **KMS**
- Automated backups, snapshots and replicas are also **encrypted**
- Encryption in flight using SSL (same proccess as MYSQL or Postgres)
- **Possibility to autheticate usig IAM token** (same method as RDS)
- You are responsible for protecting the instance with security groups
- **You can't SSH**
## Aurora Repliccas - Auto Scaling
- Write endpoint
- Many request to Reader endpoint and edpoint extended above replicas auto sccaling policies and shared storage volume
## Aurora - Custom Endpoints
- Define a subset of Aurora **Instannces** as a Custom endpoint
- Example: Run analytical queries on specific **replicas**
- The reader Endpoint is generally not used after defining custom endpoints
## Aurora Serverless
- *Automated database instantiation and auto scaling based on actual usage*
- Good for *infrequent*, *intermittent* or *unpredictable* workloads
- No capacity plannig needed
- Pay per second, can be **most cost-effective**
- **Proxy** fleet is managed by Aurora
## Aurora Multi-Master
- In case you want immediate failover for write node (HA)
- Every node does R/W - vs promoting a RR as the new master
## Global Aurora
- Aurora cross region read replicas
    - Usefule for *disaster recovery*
    - Simple to put in place
- Aurora Global Database (recommended):
    - **1 primary region** (read / write)
    - Up to **5 secodary (read only) regions**, replication lag is less than 1 second
    - Up to **16 read repliccas** per secondary region
    - Helps for decreasing latency
    - Promotig another region (for disater recovery) has an RTO of < 1 minute
## Aurora Machine Learning
- Enables you to add **ML-based predictions** to your applications via SQL
- Simple, optimized and secure integration between Aurora and AWS ML services
- Supported services
    - **Amazon SageMaker** (use with any ML model)
    - **Amazon Comprehend** (for sentiment analysis)
- You don't need to have ML experience
- Use cases: *fraud detection, ads targeting, sentiment analysis, product recommendations*
## Amazon ElastiCache Overview
- The same way RDS is to get managed Relational Databases...
- **ElastiCache** is to get managed Redis or Memcached
- Caches are in-memory databases with really high performance, low latency
- Helps reduce load off of databases for read intensive workloads
- Helps make your application stateless
- AWS takes care of OS maintanance / patching, optimizations, setup, configuration, monitoring, failure recovery and backups
- Using ElastiCache involves **heavy application code changes**
## ElastiCache Solution Architecture - DB Cache
- Applications queries Elasticacche, if not available, get from RDS and store in ElastiCache
- Helps relieve load in RDS
- Cache must have an invalidation strategy to make sure only the most current data is used in there.
## ElastiCache Solution Architecture - User Session Store
- User logs into any of the application
- The application *writes the session data into ElastiCache*
- The user hits another instance of our application
- The instance retrieves the data ans the user is already logged in
- The user retrieve session from ElastiCache
## Elasticache: Redis vs Memcached
- Redis:
    - Multi AZ with Auto Failover
    - Read replicas to scale read and have availability
    - Data durability using AOF persistence
    - Backup and restore features
- Memcached
    - Multi-node for pariniong of data (sharding)
    - No high availability (replicationn)
    - Non persistent
    - No Backup and restore
    - Multi threaded architedture
## ElastiCache - Cache Security
- All caches in ElastiCache
    - **Do not support IAM authentication**
    - IAM policies on ElastiCache are only used for **AWS API-level security**
- Redis AUTH
    - You **can set a "password/token"** when you ccreate a Redis cluster
    - This is an extra level of security for your cache (on top of security groups)
    - Support SSL in flight encryptionn
- Memcached
    - Supports **SASL-based authentication** (advanced)
## Patterns for ElastiCache
- Lazy Loading: all the read data is cached, data can become state in cache
- Write Through: Adds or update data in the cache when written to a DB (no scale data)
- Session Store: store temporary session data in a cache (using TTL features)
- Qoute: There are only two hard things in Computer Science: cache invalidation and naming things
## ElastiCache - Redis Use Case
- Gaming leadeerboards are coomputationally complex
- Redis Sorted sets guarantee both uniqueness and element ordering
- Each time a new elemennt added, it's ranked in real time, then added in correct order
