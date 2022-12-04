---
title: 'AWS Advance: ElastiCache, RDS, and Aurora part 2'
categories:
- Fullstack
- Architect
- AWS
tags:
- aws
- RDS
- Encryption
- DisaterRecovery
- Security
- Encapsolution
---

# RDS. Aurora & ElastiCache
## AWS RDS Overview
- RDS stannds for Relatioal Database service
- It's a managed DB service for DB use SQL as a query language.
- It allow you to create databases in the cloud that are managed by AWS
    - Postgres
    - MYSQL
    - MariaDB
    - Oracle
    - Microsoft SQL Server
    - Aurora(AWS Proprietary database)
## Advantage over using RDS versus deploying DB on EC2 
- RDS is a managed service:
    - Automated provisioning, OS patching
    - Conitnous backups and restore to *specific timestamp* (Point in Time Restore)!
    - Monitoring dashboard
    - Read replicas for improved read performance
    - Maintennace windows for upgrade
    - Sacling capacity (vertical and horizotal)
    - Storage backed by EBS (gp2 or io1)
- But you can't SSH into your instances
## RDS backups
- Backups are **automatically** enabled in RDS
- **Automated backups**:
    - Daily full backup of the database (durinng the maintenancce window)
    - Transaction logs are baccked-up by RDS every **5 minutes**
    - ability to restore to any point in time (from oldest to 5 minutes ago)
    - 7 days retention (can be increased to 35 days)
- DB **snapshots**:
    - **Manually** triggered by the user
    - Retention of backup for as long as you want
## RDS Storage Auto Scaling
- Helps you increase storage on your RDS DB instannce **dynamically**
- When RDS detects you are running out of free database storage, it scales automatically
- Avoid manually scaling your database storage
- You have to set Maximum Storage Threshold (maximum limit for DB storage)
- Automatically modify storage if
    - Free storage is less than 10% of alloccated storage
    - Low storage lasts at least 5 minutes
    - 6 hours have passed sincce last modification
## RDS Read Replicas for read scalability
- **Up to 5 read replica**s 
- Within AZ, Cross AZ or Cross Region
- Replication is ASYNC, so reads are eventually consistent 
- Replicas can be promoted to their own DB
- Applications must update the connection string to leverage read replicas
## RDS Read replicas - Use Cases
- You have a production database that is taking on normal load
- You want to run a reporting application is unfacted 
- Read replicas are used for SELECT(=read) only kind of statements (not INSERT, UPDATE, DELETE)
## RDS Read Replicas - Network Cost
- In AWS there's a networ cost when data goes from one AZ to another
- For RDS read replicas within the same region, you don't pay that fee
## RDS Multi AZ (Disater Recovery)
- Sync replication
- One **DNS** name - automactic app failover too standby
- Increase availability
- **Failover** in case of loss AZ, loss of networkk, instance or storage failure
- No manual intervention in apps
- Not used for scaling
- **Multi AZ replication is free**
- Note: The Read Replicas bet setup as Multi AZ for** Disater Recovery**
## RDS - From Single AZ to Multi AZ
- Zero downtime operation (no need to stop the DB)
- Just click on "modify" for the database
- The following happens internally:
    - A **snapshot** is taken
    - A new DB is retored from the snapshot in a new AZ
    - **Syncchronization** is establishhed between the two databases
## RDS Security - Encryption
- **At rest ecryption**
    - Possibility to encrypt the master & read replicas with **AWS KMS - AES-256** encryption
    - Enccryption has to be defined at launch time
    - If the master is not encrypted the read replicas cannot be encrypted
    - Transparent Data Encryption (TDE) available for Oracle and SQL Server
-** In-flight encryption**
    - SSL certificates to encrypt data to RDS in flight
    - Provide SSL options with trust certificate when connecting to database
    - To enforce SSL:
        - PostgreSQL: rds.force_ssl=1 i QWS RDS console
        - MYSQL: Within the DB
        - Grant Usage On *.* To 'mycluster'@'%' Require SSL;
## RDS Encryption Operations
- Encrypting RDS backups
    - Snapshots of un-crypted RDS databases are un-crypted
    - Sapshots of enncrypted RDS databases are encrypted
    - Can copy a snapshot into an encrypted one
- To encrypt an un-encrypted RDS database
    - Create a snapshot of the un-encrypted database
    - Copy the snapshot and enable encryption for the snapshot
    - Restore the database from the encrypted snapshot
    - Migrate applications to the new database, and delete the old database
## RDS Security - Network & IAM
- Network Security
    - RDS databases are usually deployed **within a private subnet**, not in a public one
    - RDS security works by leveraging seccurity groups (the same concept as for EC2 instances)
    - it controls which ip / security group can comminicate with RDS
- Access Management
    - **IAM policies** help control who can manage AWS RDS (through the RDS *API*)
    - **Tranditionnal Username annd Password** can be used to *login* into the database
    - **IAM-based authentication** can be used to login into RDS MYSQL & PostgreSQL
## RDS - IAM Authentication
- IAM database authentication works with MYSQL and PostgreSQL
- You don't need a password, just an authentication token obtained through IAM & RDS API calls
- Auth token has a llifetime of 15 minutes
- Benefits:
    - Networkk in/out must be encrypted using SSL
    - IAM to cenntrally manage users instead of DB
    - Cann leverage IAM roles and EC2 instance profiles for easy integration
## RDS Security - Summary
- Encryptionn at rest
    - is done only when you first create the DB instance
    - or: unencrypted DB => snapshot => ccopy snapshot as ecrypted => create DB from sapshot
- Your resposibility:
    - Checck the ports / IP / security group inbound rules in DB's SG
    - In-database user creation and permission or manage through IAM
    - Creating a database with or without public access
    - Ensure parameter groups or DB is configured to only allow SSL connections
- AWS responsibility
    - No SSH access
    - No manual DB patching
    - No manual OS patching
    - No way to audit the underlying instance
