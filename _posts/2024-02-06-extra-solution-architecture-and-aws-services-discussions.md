---
title: Extra Solution Architecture and AWS Services discussions
tags:
- FanOut
- SNS
- SQS
- Lambda
- EC2
- SA
- Solution
- Pattern
- CloudFront
- WAF
- ALB
- Solution Architecture
- HighPerformance Computing
- Cache
- NLB
categories:
- Fullstack
- Architect
- AWS
---

# Extra Solution Architecture and AWS Services discussions
## Lambda, SNS & SQS
- SQS + Lambda
- SQS FIFO + Lambda
- SNS asynchroous to Lambda + SQS
## Fan Out Pattern: deliver to multiple SQS
- SDK put SQSs
- SDK put SNS subcrible SQS(fan out)
## S3 Events
- S3: objectCreated, S3:ObjectRemove, S3:ObjectRestore, S3:Replication...
- Object name filtering possible (\*.jpg)
- Use case: generate thumbnails of images upload to S3
- Can create as many "S3 events" as desired
- S3 event notificatiions typically deliver events in secconds butt can sometimes take a minutesor longer
- If two writes are made to a single non-versioned object at the same time, it is possible that only a single event notification will be sent
- If you want to ensure tthat an event notification is sent for every successful write you can enable versioning on your bucket
## Caching Strategies
- Clientt -> CloudFront -> API gateway -> App Logic  Ec2 / Lambda -> Redis Memcached -> Database
- Cliennt -> CloudFront(Edge) -> S3
- Caching, TTL, Network, Computation, Cost, Latency
## Blocking an IP address
- EC2 Instance Public IP
+ Optional Firewall Software in EC2s
- NACL + Security groups
## Blocking an IP address – with an ALB
- Application Load Balancer Connection Termination
- EC2 Instance Private IP
## Blocking an IP address – with an NLB
- Network Load Balancer Traffic goes through No Security Group
## Blocking an IP address – ALB + WAF
- ALB + WAF(IP address filtering)
## Blocking an IP address – ALB, CloudFront WAF
- Client -> CloudFront(GEO Restriction) -> WAF IP address filtering
                                        -> CloudFrontt Public IPs
    -> Public ALB -> EC2 Security group
## High Performance Computing (HPC)
- The cloud is perfect place to perform HPCC
- You can create a very high number of resources in no time
- You can speed up time to results by adding more resources
- You can pay only for the systems you have used
- Perform genomics, computation chemistry, financial risk modeling, weather predictionn, machine learning, deep learning, autonomous driving
- Which services help perform HPC?
## Data Management & Transfer
- AWS Direct Connect
    - Move GB/s of data to the cloud, over a private secure network
- Snowball & Snowmobile
    - Move PB of data to the cloud
- AWS DataSync
    - Move large amount of datta between on-premises and S3, EFS, FSc for Windows
## Compute and Nettworking
- EC2 Instances:
    - CPU optimized, GPU opttimized
    - Spot Instances / Spot Fleets for cost savings + Auto Scaling
- EC2 Placement Groups: Cluster for good network performance
- Placement group cluster low latency 10Gbps network
## Compute and Networking
- EC2 Enhaced Networking (SR-IOV)
    - Higher bandwidth, higher PPS (packet per second), lower latency
    - Option1: Elastic Network Adapter (ENA) up to 100 Gbps
    - Option2: Intel 82599 VF up to 10 Gbps - LEGACY
- Elastic Fabric Adapter (EFA)
    - Improved ENA for HPC, only works for linux
    - Greate for inter-node communication, tighly coupled workloads
    - Leverages Message Passing Interface (MPI) standard
    - Bypasses the underlying Linux OS to provide low-latenccy, reliable trannsport
## Storage
- Instance-attached storage
    - EBS: scale up to 256000 IOPS with io2 Block Express
    - Instance Store: Scale tto millions of IOPS, linked to EC2 instancee, low latenccy
- Network storage:
    - Amazon S3: large blob, not a file system
    - Amazon EFS: scale IOPS based on ttottal size, or use provisioned IOPS
    - Amazon FSx for Lustre:
        - HPC optimized distributed file system, milions of IOPS
        - Backed by S3
## Automation and Orchestration
- AWS Batch
    - AWS BAtch supports multi-node parallel jobs, which enables you to run single jobs that span multtiple EC2 instances
    - Easily schedule jobs and launch EC2 instances accordingly
- AWS ParallelCluster
    - Open-source cluster management tool to deploy HPC on AWS
    - Configure with text files
    - Automate creation of VPC, subnet, clusterr type and instancce types
    - Abiliitty to enable EFA on the cluster (improves nnetwork performance)
## Creating a highly available EC2 instance
## Creating a highly available EC2 instance With an Auto Scaling Group
## Creating a highly available EC2 instance width ASG + EBS
## Creating a highly available EC2 instance
- HA options for the bastion host
    - Run2across2AZ
    - Run 1 across 2 AZ with 1 ASG 1:1:1
- Routing to the bastion host
    - If 1 bastion host, use an elastic IP with
    - ec2 user-data script to access it
    - If 2 bastion hosts, use an Network Load Balancer (layer 4) deployed in multiple AZ
    - If NLB, the bastion hosts can live in the private subnet directly
- Note: Can't use ALB as ALB is layer 7(HTTP protocol)
