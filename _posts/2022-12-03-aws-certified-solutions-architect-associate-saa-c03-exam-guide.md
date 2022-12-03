---
title: AWS Certified Solutions Architect - Associate (SAA-C03) Exam Guide
categories:
- Fullstack
- Architect
- AWS
tags:
- aws
---

## Content outline
This exam guide includes weightings, test domains, and task statements for the exam. It is not a
comprehensive listing of the content on the exam. However, additional context for each of the task
statements is available to help guide your preparation for the exam. The following table lists the main
content domains and their weightings. The table precedes the complete exam content outline, which
includes the additional context. The percentage in each domain represents only scored content.


| Domain |                                                                                               % exam  |
| -------- | -------- |
| Domain 1: Design Secure Architectures                         |  30%    |
| Domain 2: Design Resilient Architectures                     |  26%    |
| Domain 3: Design High-Performing Architectures   |  24%    |
| Domain 4: Design Cost-Optimized Architectures     |  20%    |
| Total                                                                                                       |  100%    |

## Domain 1: Design Secure Architectures

Task Statement 1: Design secure access to AWS resources.
knowledge of:
* Access controls and management across multiple accounts
* AWS federated access and identity services (for example, AWS Identity and Access: IAM, AWS SSO
* AWS global infrastructure (Availbility zone and Access Managment , AWS Region)
* AWS Security best practicle 
* The AWS shared responsibility model

Skill in:
* Applying AWS security best practices to IAM users and root users (for example mutil-factor authentication [MFA])
* Designing a flexible authoriation model that includes IAM users, groups, roles, and policies
* Designing a role based access control strategy (for example AWS Security Token Service [AWS STS], role switching, cross account access)
* Designing a security strategy for multiple AWS accounts (for example, AWS Control Tower, service control policies [SCPs])
* Determining the appropriate use of resource policies for AWS services
* Determining when to federate a directory service with IAM roles

Task Statement 2: Design secure workloads and applications.
Knowledge of:
* Application configuration and credentials security
* AWS service endpoints
* Control ports, protocol, and network traffic on AWS
* Secure appplication access
* Security services with appropriate use cases (for example Amaon Cognito, Amazon GuardDuty, Amazon Macie)
* Threat vector external to AWS (for example DDos, SQL Injection)

Skill in: 
* Designing VPC architectures with security components (for example, security groups, route table, network ACLs, NAT gateways)
* Determining network segmentation stategies (for example, using public subnets and private subnets)
* Intergrating AWS services to secure applications (for example, AWS Shield, AWS WAF, AWS SSO, AWS Secrets Manager)
* Securing external network connections to and from the AWS Cloud (for example VPN, AWS Direct Connect)

Task Statement 3: Determine appropriate data security controls
Knowledge of:
* Data access and governance
* Data recovery
* Data retention and classification
* Encryption and appropriate key management

Skills In:
* Aligning AWS technologies to meet compliance requirements
* Encription data at rest (AWS Key Management Service [AWS KMS])
* Encrypting data in transit (AWS certificate manager ACM using TLS)
* Implementing acces policies for encryption keys
* Implementing policies for data access, life cycle and protection
* Rotating encryption key and renewing certificates

## Design Resilient Architectures
task statement 3: Determine approriate data security controls

knowledge of:
* API creation and management (API Gateway, REST API)
* AWS managed services with appropriate use cases (AWS Transfer family, Amaon simple queue services, secret manager)
* Caching strategies
* Design principles for microservices (stateless workloads compared with stateful workloads)
* Event-driven architectures
* Horizontal scaling and vertical scaling
* How to appropriately use edge accelerators ( content delivery network CDN)
* How to migrate application into container
* Load balancing concept (application load balancer
* Multi-tier architectures
* Queuing and messaging concepts (publish/subcrile)
* Serverless technologies and patterns (for example, AWS Fargate, AWS Lambda)
* Storage types with associated characteristics (for example, object, file, block)
* The orchestration of containers (for example, Amazon Elastic Container Service [Amazon ECS],Amazon Elastic Kubernetes Service [Amazon EKS])
* When to use read replicas
* Workflow orchestration (for example, AWS Step Functions)

Skills in:
* Designing event-driven, microservice, and/or multi-tier architectures based on requirements
* Determining scaling strategies for components used in an architecture design
* Determining the AWS services required to achieve loose coupling based on requirements
* Determining when to use containers
*  Determining when to use serverless technologies and patterns
*  Recommending appropriate compute, storage, networking, and database technologies based
on requirements
* Using purpose-built AWS services for workloads

Task Statement 2: Design highly available and/or fault-tolerant architectures. 
Knowledge of:
* AWS global infrastructure (for example, Avaialbility ones, AWS Regions, Amazon Route 53)
* AWS managed services with approiate use c ases (Amazon comprehend, Amazone Polly)
* Basic networking concepts (for example, route tables)
* Disaster recovery strategies(DR), backup and restore, pilot light, warm standby, active - active failover, recovery point objective [RPO], recovery time objective [RTO]) 
* Distributed design pattern
* Failover strategies
* Immutable infrastructure
* load balancing concept (Application load balancer)
* Proxy concept (Amazon RDS Proxy)
* Service quotas and throttling (how to configure the service qoutas for a workload in a standby environment)
* Storage options and characteristics (for example, durability, replication)
*  Workload visibility (for example, AWS X-Ray)

Skills in:
* Determining automation strategies to ensure infrastructure integrity
*  Determining the AWS services required to provide a highly available and/or fault-tolerant  Determining the AWS services required to provide a highly available and/or fault-tolerant
*  Identifying metrics based on business requirements ti deliver a high available solution
*  Implementing designs to mitigate single point of failure
*   Implementing strategies to ensure the durability and availability of data (for example, backups)
*   Selecting an appropriate DR strategy to meet business requirements
* Using AWS services that improve the reliability of legacy applications and applications not built
for the cloud (for example, when application changes are not possible)
* Using purpose-built AWS services for workloads

## Design high performing architectures

Task Statement 1: Determine high-performing and/or scalable storage solutions

Knowledge of:
*  Hybrid storage solutions to meet business requirements
*   Storage services with appropriate use cases (for example, Amazon S3, Amazon Elastic File System [Amazon EFS], Amazon Elastic Block Store [Amazon EBS])
*   Storage types with associated characteristics (for example, object, file, block)
Skills in:
* Determining storage services and configurations that meet performance demands
* Determining storage services that can scale to accommodate future needs

Task Statement 2: Design high-performing and elastic compute solutions.

Knowledge of:
* AWS compute services with appropriate use cases (for example, AWS Batch, Amazon EMR,
Fargate)
* Distributed computing concepts supported by AWS global infrastructure and edge services
* Queuing and messaging concept (for example, publish/subcrible)
* Scalabilities with appropriate use cases (EC2 Auto Scaling, AWS Auto Scaling 
* Serverless technology and patterns (Lambda, fargate
*  The orchestration of containers (for example, Amazon ECS, Amazon EKS)
Skill in:
* Decoupling workloads so that components can scale independently
* Identifing metrics and conditions to perform scaling actions
* Selecting the appropriare resource type and size (the amount of Lambda memory) to meet business requirements

Task Statement 3: Determine high-performing database solutions.
Knowledge of:
* AWS global infrastructure (for example, Availability Zones, AWS Regions)
*  Caching strategies and services (for example, Amazon ElastiCache)
*  Data access patterns (for example, read-intensive compared with write-intensive)
*   Database capacity planning (for example, capacity units, instance types, Provisioned IOPS)
*    Database connections and proxies
*     Database engines with appropriate use cases (for example, heterogeneous migrations,
homogeneous migrations)
 * Database replication (for example, read replicas)
 * Database types and services (for example, serverless, relational compared with non-relational,
in-memory)
Skills in:
* Configuring read replicas to meet business requirements
* Designing database architectures
*  Determining an appropriate database engine (for example, MySQL compared with PostgreSQL)
*   Determining an appropriate database type (for example, Amazon Aurora, Amazon DynamoDB)
*   Integrating caching to meet business requirements

Task Statement 4: Determine high-performing and/or scalable network architectures.

Knowledge of:
* Data analytics and visualization services with appropriate use cases (for example, Amazon
Athena, AWS Lake Formation, Amazon QuickSight)
*  Data ingestion patterns (for example, frequency)
*  Data transfer services with appropriate use cases (for example, AWS DataSync, AWS Storage Gateway)
*  Data transfer services with appropriate use cases (for example, AWS DataSync, AWS Storage
Gateway)
*  Secure access to ingestion access points
*  Sizes and speeds needed to meet business requirements
*   Streaming data services with appropriate use cases (for example, Amazon Kinesis)

Skill In:
* Building and securing data lakes
* Designing data streaming architectures
* Design data transfer solutions
* Implementting visualization strategies
* Selecting appropriate ccompute options for data processing (Amazon EMR)
* Selecting appropriate configurations for ingestion
* Transforming data between formats (.csv to .parquet)

## Design Cost-Optimized Architectures
Task Statement 1: Design cost-optimized storage solutions.

Knowledge of:
*  Access options (for example, an S3 bucket with Requester Pays object storage)
*  AWS cost management service features (for example, cost allocation tags, multi-account
billing)
* AWS cost management tools with appropriate use cases (for example, AWS Cost Explorer, AWS Budgets, AWS Cost and Usage Report)
*  AWS storage services with appropriate use cases (for example, Amazon FSx, Amazon EFS, Amazon S3, Amazon EBS)
*  Backup strategies
*  Block storage options (for example, hard disk drive [HDD] volume types, solid state drive [SSD] volume types)
*  Data lifecycles
*  Hybrid storage options (for example , DataSync, Transfer Family, Storage Gateway)
*  Storage access patterns
*  Storage tiering (for example, cold tiering for object storage)
*   Storage types with associated characteristics (for example, object, file, block)

Skills in:
* Designing appropriate storage strategies (for example, batch uploads to Amazon S3 compared
with individual uploads)
*  Determining the correct storage size for a workload
*   Determining the correct storage size for a workload
*   Determining when storage auto scaling is required
*    Managing S3 object lifecycles
*    Selecting the appropriate backup and/or archival solution
*  Selecting the appropriate service for data migration to storage services
*  Selecting the appropriate storage tier
*  Selecting the correct data lifecycle for storage
*  Selecting the most cost-effective storage service for a workload

Task Statement 2: Design cost-optimized compute solutions

Knowledge of:
*  AWS cost management service features (for example, cost allocation tags, multi-account
billing)
* AWS cost management tools with appropriate use cases (for example, Cost Explorer, AWS
Budgets, AWS Cost and Usage Report)
*  AWS global infrastructure (for example, Availability Zones, AWS Regions)
*   AWS purchasing options (for example, Spot Instances, Reserved Instances, Savings Plans)
*   Distributed compute strategies (for example, edge processing)
*    Hybrid compute options (for example, AWS Outposts, AWS Snowball Edge)
*     Instance types, families, and sizes (for example, memory optimized, compute optimized,
virtualization)
*  Optimization of compute utilization (for example, containers, serverless computing,
microservices)
*  Scaling strategies (for example, auto scaling, hibernation)

Skills in:
* Determining an appropriate load balancing strategy (for example, Application Load Balancer
[Layer 7] compared with Network Load Balancer [Layer 4] compared with Gateway Load
Balancer)
* Determining appropriate scaling methods and strategies for elastic workloads (for example,
horizontal compared with vertical, EC2 hibernation)
* Determining cost-effective AWS compute services with appropriate use cases (for example,
Lambda, Amazon EC2, Fargate)
* Determining the required availability for different classes of workloads (for example,
production workloads, non-production workloads)
* Selecting the appropriate instance family for a workload
* Selecting the appropriate instance size for a workload

Task Statement 3: Design cost-optimized database solutions.

Knowledge of:
* AWS cost management service features (for example, cost allocation tags, multi-account
billing)
*  AWS cost management tools with appropriate use cases (for example, Cost Explorer, AWS
Budgets, AWS Cost and Usage Report)
* Caching strategies
* Data retention policies
* Database capacity planning (capacity units)
* Database connection and proxies
* database engines with appropriate use case (heterogeneous migrations, homogeneous migrations)
* database replication (read replica)
* database types and services (relation compared with non-relational, Aurtora, Dynamo DB)

Skills in:
-  Designing appropriate backup and retention policies (for example, snapshot frequency)
-   Determining an appropriate database engine (for example, MySQL compared with
PostgreSQL)
-  Determining cost-effective AWS database services with appropriate use cases (for example,
DynamoDB compared with Amazon RDS, serverless)
-  Determining cost-effective AWS database types (for example, time series format, columnar
format)
-  Migrating database schemas and data to different locations and/or different database engines

Task Statement 4: Design cost-optimized network architectures.

Knowledge of:
- AWS cost management service features (for example, cost allocation tags, multi-account
billing)
- AWS cost management tools with appropriate use cases (for example, Cost Explorer, AWS
Budgets, AWS Cost and Usage Report)
- Load balancing concepts (for example, Application Load Balancer)
-  NAT gateways (for example, NAT instance costs compared with NAT gateway costs)
-  Network connectivity (for example, private lines, dedicated lines, VPNs)
-  Network routing, topology, and peering (for example, AWS Transit Gateway, VPC peering)
-  Network services with appropriate use cases (for example, DNS)

Skills in:
*  Configuring appropriate NAT gateway types for a network (for example, a single shared NAT gateway compared with NAT gateways for each Availability Zone)
*   Configuring appropriate network connections (for example, Direct Connect compared with
VPN compared with internet)
* Configuring appropriate network routes to minimize network transfer costs (for example,
Region to Region, Availability Zone to Availability Zone, private to public, Global Accelerator,
VPC endpoints)
* Determining strategic needs for content delivery networks (CDNs) and edge caching
* Reviewing existing workloads for network optimizations
* Selecting an appropriate throtting strategy
* Selecting the appropriate bandwidth allocation for a network device (a single VPN compared with multiple VPNs, Direct Connect speed)
