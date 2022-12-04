---
title: AWS concept and classic Solutions Architecture
---

# AWS Concept for solution architect
## AWS History
- 2002 Internally launched
- 2003 Amazon infrastructure is one of their core strength. Idea to market
- 2004 Launched publicly with SQS
- 2006 Re-launched publicly with SQS, S3 & EC2
- 2007 Launched in Europe
## AWS Cloud Number Facts
- In 2019, AWS had $35.02 billion in annual revenue
## AWS Cloud Use Cases
- AWS enables you to build sophisticated, scalable applications
- Applicable to a diverse set of industries
- Use cases include
       - Enterprise IT, Backup & Storage, Big Data analytics
       - Website hosting, Mobile & Social Apps
       - Gaming
## AWS Global Infrastructure
- AWS Region
- AWS Availability Zones
- AWS Data centers
- AWS Edge Locations / Points of presence
![AWS infrastructure](https://ibb.co/ZM2twHd "AWS infrastructure")
### AWS Regions
- AWS has regions all around the world
- Names can be us-east-1, eu-west-3...
- A region is a **cluster** of **data centers**
- Most AWS seervices are region-scoped
### How to choose an AWS Region
- **Compliance** with data goverance and legal requirements data never leaves a region without your explicit permission
- **Proximity** to customers: reduced latency
- **Avaiable services** with in a Region new services and new features aren't avaiable in every Region
- **Pricing** pricing varies region to region and is transparent in the sevice pricing page
### AWS Availability Zones
- Each region has many availability zones (usually 3, min is 2, max is 6).
    - ap-southeast-2a
    - ap-southeast-2b
    - ap-southeast-2c
- Each availability zone (AZ) is one or more **discrete data centers** with redundant **power**, **networking**, and **connectivity**
- They’re separate from each other, so that they’re isolated from disasters.
- They're connected with high bandwidth ultra-low latency networking
### AWS Points of Presence
- Amazon has 216 points of presence (205 edge locations & || Regional caches) in 84 cities across 42 countries
- Content is delivered to end users with low latency
### Tour of the AWS console
- AWS hash Global Services
    - Identty and Access Management(IAM)
    - Route 53(DNS service)
    - CloudFront (Content Delivery Network)
    - WAF (Web application firewall)
- Most AWS services are region-scoped
    - Amazone EC2 (Infrastructure as a Service)
    - Elastic Beanstalk
    - Lambda (Function as a Service)
    - Rekognition (Software as a Service)
- Region Table


### DNSSEC Domain Name System Security Extensions
DNSSEC strengthens authentication in DNS using digital signatures based on public key cryptography. With DNSSEC , it's not DNS queries and responses themselves that are cryptographically signed, but rather DNS data itself is signed by the owner of the data.
## AWS Organizations
It's architecture and some of the benefits for businesses managing larger numbers of AWS Accounts.
- The **GENERAL** account will become the **MASTER** account for the organisation
- We will invite the **PRODUCTION** account as a MEMBER account and create the **DEVELOPMENT** account as a MEMBER account.
- Finally - we will create an OrganizationAccountAccessRole in the production account, and use this role to switch between accounts.
- Create AWS Role
- Create Aws Account name
- Email invite
## Service Control Policies (SCP)
I introduce service control policies - a feature of AWS **Organizations** which allow **restrictions** to be placed on **MEMBER** accounts in the form of *boundaries*.
**SCPs** can be applied to the organization, to OU's or to individual accounts.
**Member** accounts can be affected, the **MANAGEMENT** account cannot.
SCPs DON'T GIVE permission - they just control what an account CAN and CANNOT *grant* via identity policies.
ex: apply an SCP to the PRODUCTION account to test their capabilities.
## Security token service(STS)
AWS provides AWS Security Token Service (AWS STS) as a **web service** that enables you to request **temporary**, **limited-privilege** credentials for AWS Identity and Access Management (**IAM**) users or for users you **authenticate** (federated users). This guide describes the AWS STS API.
By default, AWS Security Token Service (AWS STS) is available as a global service, and all AWS STS requests go to a single endpoint at https://sts.amazonaws.com.
- sts:AssumeRole
## IAM Role Temporary Security credentials
You can use the **AWS Security Token Service** (AWS STS) to *create* and *provide* trusted users with **temporary security** credentials that can control access to your AWS resources. Temporary security credentials work almost identically to the long-term access key credentials that your IAM users can use, with the following differences:
- Temporary security credentials are short-term, as the name implies. They can be configured to last for anywhere from a few minutes to several hours. After the credentials expire, AWS no longer recognizes them or allows any kind of access from API requests made with them.
- Temporary security credentials are not stored with the user but are generated dynamically and provided to the user when **requested**. When (or even before) the temporary security credentials expire, the user can request new credentials, as long as the user requesting them still has **permissions** to do so.
- security-credentials
- example: *Revoking Temporary Credentials by curl*
    - permission revoke
## Policies and permissions in IAM
- Most policies are stored in AWS as JSON documents. AWS supports six types of policies:
    - identity-based policies,
    - resource-based policies,
    - permissions boundaries,
    - Organizations SCPs,
    - ACLs, and session policies.
- Version – Specify the version of the policy language that you want to use. As a best practice, use the latest 2012-10-17 version.
- Statement – Use this main policy element as a container for the following elements. You can include more than one statement in a policy.
- Sid (Optional) – Include an optional statement ID to differentiate between your statements.
- Effect – Use Allow or Deny to indicate whether the policy allows or denies access.
- Principal (Required in only some circumstances) – If you create a resource-based policy, you must indicate the account, user, role, or federated user to which you would like to allow or deny access. If you are creating an IAM permissions policy to attach to a user or role, you cannot include this element. The principal is implied as that user or role.
- Action – Include a list of actions that the policy allows or denies.
- Resource (Required in only some circumstances) – If you create an IAM permissions policy, you must specify a list of resources to which the actions apply. If you create a resource-based policy, this element is optional. If you do not include this element, then the resource to which the action applies is the resource to which the policy is attached.
- Condition (Optional) – Specify the circumstances under which the policy grants permission.
- example: experience a few ways to access S3 using cross-account access
- example: access S3 using bucket policy
## Resource Access Manager
Resource Access Manager (RAM) allows AWS resources to be shared between AWS Accounts.It can be used to support certain common architectures such as a Shared Services VPC.
## Service endpoints and quotas
- To connect programmatically to an AWS service, you use an endpoint.
- Service quotas, also referred to as limits, are the maximum number of service resources or operations for your AWS account.
- Example:
    + Cloudwatch
    + A quota request template
```sh
aws service-quotas list-service-quotas \
    --service-code cloudformation

list-aws-default-service-quotas
    --service-code <value>
    [--cli-input-json | --cli-input-yaml]
    [--starting-token <value>]
    [--page-size <value>]
    [--max-items <value>]
    [--generate-cli-skeleton <value>]
    [--debug]
    [--endpoint-url <value>]
    [--no-verify-ssl]
    [--no-paginate]
    [--output <value>]
    [--query <value>]
    [--profile <value>]
    [--region <value>]
    [--version <value>]
    [--color <value>]
    [--no-sign-request]
    [--ca-bundle <value>]
    [--cli-read-timeout <value>]
    [--cli-connect-timeout <value>]
    [--cli-binary-format <value>]
    [--no-cli-pager]
    [--cli-auto-prompt]
    [--no-cli-auto-prompt]

request-service-quota-increase
    --service-code <value>
    --quota-code <value>
    --desired-value <value>
    [--cli-input-json | --cli-input-yaml]
    [--generate-cli-skeleton <value>]
    [--debug]
    [--endpoint-url <value>]
    [--no-verify-ssl]
    [--no-paginate]
    [--output <value>]
    [--query <value>]
    [--profile <value>]
    [--region <value>]
    [--version <value>]
    [--color <value>]
    [--no-sign-request]
    [--ca-bundle <value>]
    [--cli-read-timeout <value>]
    [--cli-connect-timeout <value>]
    [--cli-binary-format <value>]
    [--no-cli-pager]
    [--cli-auto-prompt]
    [--no-cli-auto-prompt]
```
```
{
    "Quotas": [
        {
            "ServiceCode": "xray",
            "ServiceName": "AWS X-Ray",
            "QuotaArn": "arn:aws:servicequotas:us-west-2::xray/L-C6B6F05D",
            "QuotaCode": "L-C6B6F05D",
            "QuotaName": "Indexed annotations per trace",
            "Value": 50.0,
            "Unit": "None",
            "Adjustable": false,
            "GlobalQuota": false
        },
        {
            "ServiceCode": "xray",
            "ServiceName": "AWS X-Ray",
            "QuotaArn": "arn:aws:servicequotas:us-west-2::xray/L-D781C0FD",
            "QuotaCode": "L-D781C0FD",
            "QuotaName": "Segment document size",
            "Value": 64.0,
            "Unit": "Kilobytes",
            "Adjustable": false,
            "GlobalQuota": false
        },
        {
            "ServiceCode": "xray",
            "ServiceName": "AWS X-Ray",
            "QuotaArn": "arn:aws:servicequotas:us-west-2::xray/L-998BFF16",
            "QuotaCode": "L-998BFF16",
            "QuotaName": "Trace and service graph retention in days",
            "Value": 30.0,
            "Unit": "None",
            "Adjustable": false,
            "GlobalQuota": false
        }
    ]
}
```
## Amazon Resource Names (ARNs)

## Questions
1. What functionality does STS provide?
it generates short term credentials which can be used to interact with AWS resources.
2. Which of the following is NOT an example of a 'real' identity which can be referenced by ARNs in resource policies?
IAM Groups
3. How are role sessions revoked (Choose one)
A inline policy is added to the role with an explicit deny for role assumptions before .. NOW
4. If an SCP on the AWS account allows S3, a managed policy attached to your identity allows S3 and an inline policy denys S3.. what is your effective access (Choose one)
Denied
5. An SCP on account B denies S3. A resource policy on the bucket in account B allows account A. An identity policy on Bob in Account A allows access to S3. What is the effective access when Bob accesses the bucket in account B (choose one)
## Hash
## SSL/TLS
## Digital Signal
## AWS Public vs Private Services
## AWS Default Virtual Private Cloud (VPC)
A default VPC is created once per region when an AWS account is first created.
There can only be one default VPC **per region**, and they can be deleted and recreated from the console UI .
They always have the **same IP range and same '1 subnet per AZ'** architecture.
This lesson details and demos the functionality of a default VPC.
## Elastic Compute Cloud (EC2) Basics
- IAAS: virtual services
- Private service by default - uses VPC networking
## IAM Section
### IAM: Users & Groups
- IAM = Identity and Access Management, Global service
- `Root account` created by default, shouldn’t be used or shared
- `Users` are people within your organization, and can be grouped
- `Groups` only contain users, not other groups
- `Users` don’t have to belong to a group, and user can belong to multiple groups
### IAM: Permissions
- **Users** or **Groups** can be assigned JSON documents called policies
- These **policies** define the permissions of the users
- In AWS you apply the **least privilege principle** don't give more permission than a user needs
```json
{
"Version": "2012-10-17",
"Statement": [
    {
    "Effect": "Allow",
    "Action": "ec2:Describe*",
    "Resource": "*"
    },
    {

    "Effect": "Allow",
    "Action": "elasticloadbalancing:Describe*",
    "Resource": "*"
    },
    {
    "Effect": "Allow",
    "Action": [
    "cloudwatch:ListMetrics",
    "cloudwatch:GetMetricStatistics",
    "cloudwatch:Describe*"
    ],
    "Resource": "*"
    }
    ]
}
```
### IAM Policies inheritance
![IAM Policies inheritance](https://i.ibb.co/RH1gYDT/Screenshot-from-2022-09-14-10-44-50.png "IAM Policies inheritance")
### IAM Policies Structure
- Json structure
    - version: policy language version, alway include "2012-10-17"
    - ID: an identifier for the policy
    - Statement: one or more individual statements
     - Sid
     - Effect
     - Principal
     - Action
     - Resource
     - Condition
### IAM – Password Policy
- Strong passwords: higher security for your account
- In AWS, you can setup a password policy
    - Set a minimum password length
    - Require specific character types
     - includng uppercase letter
     - lowercase letters
     - numbers
     - non-alphanumeric characters
    - Allow all IAM users to change their own passwords
    - Require users to change their password after some time
    - Prevent password re-use
### Multi Factor Authentication    - MFA
- Users have access to your account and can possibly change configurations or delete resources in your AWS account
- You want to protect your Root Accounts and IAM users
- MFA = password you know + security device you own
- Main benefit of MFA: If a password is stolen or hacked the password is not compromised
- MFA virtual app or USB hardware Factor
- Hardware Key Fob MFA Device, Hardware Key Fob MFA Device
### How can users access AWS
- To access AWS, you have three options
    - AWS Management Console
    - AWS Command line interface
    - AWS software developer kit
- Access keys are generated through the AWS Console, password don't share
- Users manage their own access keys
- Access Key ID
- Secret Access Key
- Example
    - Access key ID: AKIASK4E37PV4983d6C
    - Secret Access Key: AZPN3zojWozWCndIjhB0Unh8239a1bzbzO5fqqkZq
### What’s the AWS CLI?
- A tool that enables you to interact with AWS services using commands in
your command-line shell
- Direct access to the public APIs of AWS services
- You can develop scripts to manage your resources
- It’s open-source https://github.com/aws/aws-cli
- Alternative to using AWS Management Console
### What’s the AWS SDK?
- AWS Software Development Kit (AWS SDK)
- Language-specific APIs (set of libraries)
- Enables you to access and manage AWS services
programmatically
- Embedded within your application
- Supports
    - SDKs (JavaScript, Python, PHP, .NET, Ruby, Java, Go, Node.js,
C++)
    - Mobile SDKs (Android, iOS, …)
    - IoT Device SDKs (Embedded C, Arduino, …)
- Example: AWS CLI is built on AWS SDK for Python
### IAM Roles for Services
- Some AWS service will need to perform actions on your behalf
- To do so, we will assign permissions to AWS services with IAM Roles
- Common roles:
    - EC2 Instance Roles
    - Lamba function roles
    - Roles for CloudFormation
### IAM Security Tools
- IAM Credentials Report: A report that list all your account's users and the status of their various credentials
- IAM Access Advisor (user-level): Access advisor shows the service permissions granted to a user and when those. You can use this information to revise your policies.
### IAM Guidelines & Best Practices
- Don't use the root account except for AWS account setup
- One physical user = One AWS user
- Assign user to groups and assign permissions to groups
- Create a strong password policy
- User and enforce the use of Multi Factor Authentication(MFA)
- Create and use Roles for giving permissions to AWS services
- User Access keys for programmactic access
- Audit permissions of your account with the IAM credentials report
- Never share IAM users & Access Keys
### IAM Section – Summary
- Users: mapped to a physical user, has a password for AWS console
- Groups: contains users only
- Policies: JSON document that outlines permissions for users or groups
- Roles: for EC2 instances or AWS services
- Security: MFA + Password policy
- Acess keys: access AWS using the CLI or SDK
- Audit: IAM credential reports & IAM Access Advisor
# EC2 Basics
## Amazon EC2
- EC2 is one of the most popular of AWS offering
- EC2 = Elastic Compute Cloud = IAAS
    - Renting virtual machines EC2
    - Storing data on virtual drives EBS
    - Distributing load acroos machines ELB
    - Scaling the services using an auto-scaling group ASG
- Knowing EX2 is fundamental to understand how the Cloud works
## EC2 sizing & configuration options
- Operating System (OS): Linux, Windows, MAC OS
- How much compute power and core: CPU
- How much random-access memory: RAM
- How much storage space:
    - Network-attached: EBS & EFS
    - Harkware: EC2 Instance Store
- Network card speed of the card, public ip address
- Firewall rules: security group
- Boostrap script: EC2 User Data
## EC2 User Data
- It is possible to bootstrap our instances using an EC2 User data script
- bootstrapping means launching commands when a machine starts
- That script is only run once at the instace first start
- EC2 user data is used to automate boot tasks such as
    - Install updates
    - Install software
    - Download common files from the internet
    - Anything you can think of
- The EC2 User data script runs with the root user
- Example:
 + Web server is launched using EC2 user data
## EC2 Instance Types    - Overview
- References to EC2 [instances](https://aws.amazon.com/ec2/instance-types/)
- example: m5.2xlarge
 + m: instance class
 + 5: generate
 + 2xlarge: size within the instance class
 ![All EC2 Instance type](https://imgdb.net/7537 "All EC2 instances type")
## EC2 Instance Types – General Purpose
- Great for a diversity of workloads such as web servers or code repositories
- Balance between:
 + Compute
 + Memory
 + Networking
- Ex: Mac, t4g, t3, t3a, t2, M6g, M6I, M6a, M5, M5a, M5n, M5zn, M4, A1
![EC2 General purpose](https://imgdb.net/7534 "EC2 General purpose")
## EC2 Instance Types – Compute Optimized
- Great for compute intensive tasks that require high performance processors:
 + Batch processing workload
 + Media transcoding
 + High performance web servers
 + High performance computing HPC
 + Scientific modeling & machine learning
 + Dedicated gaming servers
- Ex: C7g, C6g, C6gn, C6I, C6a, Hpc6a, C5, C5a, C4
![Compute Optimized](https://imgdb.net/7535 "Compute Optimized")
## EC2 Instance Types    - Memory Optimized
- Fast performance for workloads that process large data set in memory
- Use cases:
 + High performance, relational/non-relational databases
 + Distributed web scale cache store
 + In-memory database optimized for BI
 + Applications performing real-time processing of big unstructured data
![Memory Optimized](https://imgdb.net/7537 "Memory optimized")
- Ex: R6a, R6g, R6I. R5, R5a, R5b, R5n, R4, X2gd, X2ldn, X2ledn, X2lezn, X1, High Memory, z1d
## EC2 Instance Types – Storage Optimized
- Great for storage-intensive tasks that require high, sequential read and write
access to large data sets on local storage
- Use cases:
 + High frequency online transaction processing (OLTP) systems
 + Relational & NoSQL databases
 + Cache for in-memory databases (for example, Redis)
 + Data warehousing applications
 + Distributed file systems
- Ex: Im4gn, Is4gen, I4i, I3, I3en, D2, D3, D3en, H1
## EC2 Instance Types – Accelerated Computing
- Hardware accelerators, co-processors, perform functions, floating point number calculations, graphics processing, data pattern matching
- Use case: Machine learning, high performace computing, computanional fluid dynamics
- Ex: P4, P3, P2, DL1, Trn1, Irn1, Inf1, G5, G5g, G4gn, G4ad, G3, F1, VT1
# Introduction to Security Groups
- Security groups are the fundamental of network security in AWS
- They control how traffic is allowed into or out of our EC2 instances
- Security groups only contain allow rules
- Security groups rules can reference by IP or by security group
## Security Groups Deeper Dive
- Security groups are acting as a “firewall” on EC2 instances
- They regulate:
 + Access to Ports
 + Authorised IP ranges: IPv4 and IPv6
 + Control of inbound network (from other to the instance)
 + Control of outbound network (from the instance to other)
![Security Group](https://imgdb.net/7538 "Security group")
## Security Groups Good to know
- Can be attaced to multiple instances
- Locked down to a *region / VPC combination*
- Does live "outside" the EC2    - if traffic is blocked the EC2 instance won't see it
- It's good to maintain one separate security group for SSH access
- **If your application is not accessible (time out), then it's a security group issue**
- **If your application gives a "connection refused" error, then it's an application error or it's not lauched**
- All inbound traffic is blocked by default
- All outbout traffic is authorised by default
![security groups](https://imgdb.net/7539 "security groups")
## Classic Ports to know
- 22 = SSH
- 21 = FTP
- 22 = SFTP
- 80 = HTTP
- 443 = HTTPS
- 3389 = RDP
- Ec2 instance connect is popular tool for ssh, ssh commancd is avaiable for all opeartion but withou windows version less than 10, so on you need Putty
# EC2 Instance Connect
- Connect to your EC2 instance within your browser
- No need to use your key file that was downloaded
- The "magic" is that a temporary key is uploaded onto EC2 by AWS
- Work only out of the box Amazon Linux 2
- Need to make sure the port 22 is still opened!
## EC2 Instances Purchasing Options
- On-demand Instances: short workload, predictable pricing, pay by second
- Reserved (1 & 3 years)
 + Reserved instances: long workloads
 + Convertible Reserved Instances: long workloads with flexible instances
- Savings plans (1 & 3 years): Commitment to an amount of usage, long workload
- Spot Instances: short workloads, cheap, can lose instances (less reliable)
- Dedicated Hosts: Book an entire physical server, control instance placement
- Dedicated Instances: No other customers will share your hardware
- Capacity Reservations: Reserve capacity in a specific AZ for any duration
## EC2 On Demand
- Pay for what you use
 + Linux or WIndows: Bulling per second, after the first minute
 + All other operating systems: billing per hour
- Has the highest cost but no upfront payment
- No long-term commitment
- Recommended for short-term and un-interupted workloads where you can't predict how the application will behave
## EC2 Reserved Instances
- Up to 72% discounr compared to On-demand
- You reserve a specific instance attributes (Instance Type, Region, Tenancy, OS)
- Reservation Period    - 1 year(+discount) or 3 years (+++discount)
- Payment Options    - No upfront(+), Partial upfront(++), All upfront(+++)
- Reserved Instance's Scope    - Regional or Zonal (reserve capacity in an AZ)
- Recommended for steady-state usage applications (think database)
- You can buy and sell in the Reserved Instance marketplace
- Convertible Reserved Instance
 + Can change the EC2 instance type, instance family, OS, scope and tenacy
 + Up to 66% discount
## EC2 Savings Plans
- Get a discount based on long-term usage (up to 72%    - same as RIs)
- Commit to certain type of usage ($10/hour for 1 or 3 years)
- Usage beyond EC2 savings plans is billed at the On-Demand price
- Locked to a specific instance family & AWS region (e.g, M5 in us-east-1)
- Flexible across:
 + Instance Size
 + OS
 + Tenancy (Host, Dedicated, Default)
## EC2 Spot Instances
- Can get a discount of up to 90% compared to On-demand
- Instances that you can "lose" at any point of time if your max price is less than the current spot price
- The Most cost-efficient instances in AWS
- Useful for workloads that are resilient to failure
 + Batch jobs
 + Data analysis
 + Image processing
 + Any distributed workloads
 + Workloads with a flexible start and end time
- Not suitable for critical jobs or databases
## EC2 dedicated hosts
- A physical server with EC2 instance capacity fully dedicated to your use
- Allows you address compliance requirements and use your existing server bound software licenses (per-socket, per-core, pe—VM software licenses)
- Purchasing Options:
    - On-demand: pay per second for active Dedicated Host.
    - Reserved: 1 or 3 years (No Upfront, Partial Upfront, All Upfront)
- The most expensive option
- Useful for software that have complicated licensing model: BYOL Bring your own license
- Or for companies that have strong regulatory or compliance needs.
## EC2 Dedicated Instances
- Instances run on hardware that's dedicated to you
- May share hardware with other instances in same account
- No control over instance placement (Can move hardware after Stop/Start)
## EC2 Capacity Reservations
- Reserve On-demand instance capacity in a specific AZ for any duration
- You always have access to EC2 capacity when you need it
- No time commitment, no billing discount
- Combine with Regional reserved instances and savings plans to benefit from billing discounts
- You're charged at On-Demand rate whether you run instances or not
- Suitable for short-term, uninterrupted workloads that needs to be in a specific AZ
## Which purchasing option is right for me?
- On demand: coming and staying in resort whenever we like, we pay the full price
- Reserved: like planing ahead and if we plan to stay for a long time, we may get a good discount.
- Saving Plans: pay a cerain amount per hour for certain period and stay in any room type
- Spot Instance: The hotel allows people to bid for the empty rooms and the highest bidder keeps the rooms. You can get kicked out at any time
- Dedicated Hosts: We book an entire building of the resort
- Capacity Reservations: you book a room for a period with full price even you don't stay in it
## Price Comparison
- Example – m4.large – us-east-1
![Example price](https://imgdb.net/7542 "Example price")
## EC2 Spot Instance Requests
- Can get a discount of up to 90% compared to On-demand
- Define max spot price and get the instance while current spot price < max
    - The hourly spot price varies based on offer and capacity
    - If the current spot price > your max price you can choose to stop or terminate your instance with a 2 minutes grace period
- Other strategy: Spot Block
    - "block" spot instance during a specified time frame (1 to 6 hours) without interuptions
    - In rare situations, the instance may be reclaimed
- Used for batch jobs, data analysis, or workloads that are resilient to failures.
- Not greate for critical jobs or databases
## How to terminate Spot Instances?
![Spot Instances Pricing](https://imgdb.net/7548 "Spot Instances Pricing")
## Spot Fleets
- Spot Fleets = set of Spot instances + (optional) On-Demand instances
- The spot fleet will try to meet the target capacity with price constraints
    - Define possible launch pools: instance type (m5.large), OS, Avaiability Zone
    - Can ave multiple launch pools, so that the fleet can choose
    - Spot Fleet stops launching instances when reaching capacity or max cost
- Strategies to allocate Spot Instances
    - lowestPrice: from the pool with the lowest price (cost optimizations, short workload)
    - diversified: distributed across all pool (great for availability, long workloads)
    - capacityOptimized: pool with the optimal capacity for the number of instances.
## EC2 Section – Summary
- EC2 Instance: AMI (OS) + Instance Size (CPU + RAM) + Storage +
security groups + EC2 User Data
- Security Groups: Firewall attached to the EC2 instance
- EC2 User Data: Script launched at the first start of an instance
- SSH: start a terminal into our EC2 instances
- EC2 Instance Role: link to IAM roles
- Purchasing Options: On-Demand, Spot, Reversed (Standard + Convertible + Scheduled), Dedicated Host, Dedicated Instance
# EC2 – Associate
- Private vs Public IP (IPv4)
- Networking has two sorts of IPs. IPv4 and IPv6:
    - Ipv4: 1.160.10.240
    - IPv6: 3ffe:1900:4545:3:200:f8ff:fe21:67cf
- In this course, we will only be using IPv4.
- Ipv4 is still the most common
- IPv6 is newer and solves problems for the internet of Thing (IoT)
- IPv4 allow for 3.7 bilion different address in the public space
- IPv4: [0-255].[0-255].[0-255].[0-255].
## Private vs Public IP (IPv4)
- Public IP
    - public IP means the machine can be identified on the internet
    - Must be unique across the whole web
    - Can be geo-located easily
- Private IP:
    - Private Ip means the machine can only be identified on a private network only
    - The IP must be unique across the private network
    - But two different private networks (two companies) can have the same IPs
    - Machine connect to WWW using a NAT + internet gateway
    - Only a specified range of IPs can be used as private IP
## Elastic IPs
- When you stop and then start an EC2 instance, it can change its public IP.
- If you need to have a fixed public IP for your instance, you need an Elastic IP
- An Elastic IP is a public IPv4 IP you own as long as you dont delete it
- You can attach it to one instance at a time
## Elastic IP
- With an Elastic IP address, you can mask the failure of an instance or software by rapidy remapping the address to another instace in your account.
- You can only have 5 Elastic IP in your account
- Overall, try to avoid using Elastic IP:
    - They often reflect poor architectural decisions
    - Instead, use a random public IP and register a DNS name to it
    - Or as we'll see later, use a load balancer and dont use a public IP
## In AWS EC2 – Hands On
- By default, your EC2 machine comes with:
    - A private IP for the internal AWS Network
    - A public IP, for the WWW
- When we are doing SSH into our EC2 machines:
    - We can't use a private IP, because we are not in the same network
    - We can only use the public IP
- If your machine is stopped and then started **the public IP can change**
## Placement Groups Cluster
- Pros: Greate network (10 Gbs bandwith between instances with Enhanced Networking enabled)
- Cons: If the rack fails, all instances fail at the same time
- Use case:
    - Big Data job that needs to complete fast
    - Application that needs extremely low latency and high network throughput
![Placement Cluster](https://imgdb.net/7549 "placement cluster")
## Placement Groups Spread
- Pros:
    - Can span across avaiability zones (AZ)
    - Reduced risk is simultaneous failure
    - EC2 Instances are on different phusical hardware
- Cons:
    - Limited to 7 instances per AZ per placement group
- Use case:
    - Application that needs to maximize high availability
    - Critical Applications where each instance must be isolated from failure from each other
![Groups spread](https://imgdb.net/7550 "Groups spread")
## Placements Groups Partition
- Up to 7 partions per AZ
- Can span across multiple AZs in the same region
- Up to 100s of EC2 instances
- The instances in a partion do not share racks with the instances in the other partitions
- A partition failure can affect many EC2 but won't affect other partitions
- EC2 instances get access to the partition information as metadata
- Use cases: HDFS, HBase, Cassandra, Kafka
## Elastic Network Interfaces (ENI)
- Logical component in a VPC that represents a virtual network card
- The ENI can have the following attributes:
    - primary private IPv4, one or more secondary IPv4
    - One Elastic IP (IPv4) per private IPv4
    - One public IPv4
    - One or more security groups
    - A MAC address
- You can create ENI independently and attach them on the fly (move them) on EC2 instances for failover
- Bound to a specific availability zone (AZ)
## Ec2 Hibernate
- We know we can stop, termiate instances
    - stop    - the data on disk (EBS) is kept intact in the next start
    - terminate    - any EBS volumes (root) also set-up to be destroyed is lost
- On start, the following happens:
    - First start: the OS boots & the EC2 User Data script is run
    - Following starts the OS boots up
    - Then your application starts, caches get warmed up, and that can take time!
## EC2 Hibernate
- Introducing Ec2 Hibernate
- The in-memory (RAM) state is preserved
- The instance boot is much faster!
- Under the hood: the RAM state is written to a file in the root EBS volume
- The root EBS volume must be encrypted
- Long-running processing
- Saving the RAM state
- Services that take time to initialize
![EC2 Hibernate](https://imgdb.net/7551 "EC2 Hibernate")
## EC2 Hibernate – Good to know    - Accelerate EC2
- Supported Instance Families: C3, C4, C5, I3, M3, M4, R3, R4, T2, T3, …
- Instance RAM size: must be less than 150 GB
- Instance Size: not supported for bare metal instances
- AMI: Amazon Linux 2, Linux AMI, Ubuntu, RHEL, CentOS & Windows...
- Root volume: must be EBS, encrypted, not instance store and large
- Available for **On-Demand, Reserved and Spot** instances
- An instance can NOT be hibernated more than **60** days
## EC2 Nitro
- Underlying platform for the next generation of EC2 instances
- New virualization technology
- Allows for better performance
    - Better networking options (enhanced networking, HPC, IPv6)
    - Higher speed EBS (Nitro is necessary for 64.000 EBS IOPS    - max 32000 on non-Nitro)
- Better underlying security
- Instance types example:
    - Virtualized: AI, C5, C5a, C5ad, C5d, C5n, C6g, C6gn, D3, D3en, G4, I3en, Infi, M5a, M5ad, M5d, M5dn, M5n, ….
    - Bare metal: a l.metal, c5.metal, c5n.metal, c6g.metal. c6gd.metal...
## EC2 – Understanding vCPU
- Multiple threads can run on one CPU (multithreading)
- Each thread is represented as a vitual CPU (vCPU)
- Example: m5.2xlarge
    - 4 CPU
    - 2 threads per CPU
    - => 8 vCPU in total
## EC2 – Optimizing CPU options: Reservations
- EC2 instances come with a combination of RAM and vCPU
- But in some cases, you may want to chage the vCPU options:
    - # of CPU cores: you can decrease it (helpful if you need high RAM and low number of CPU)    - to decrease licensing costs
    - # of threads per core: disable multithreading to have I thread per CPU    - helpful for high performance computing (HPC) workloads
- Only specified during instance launch
## EC2 – Capacity Reservations: Reservations
- Capacity reservations ensure you have EC2 capacity when needed
- Manual or planned end date for the reservation
- No need for 1 or 3 year commitment
- Capacity access is immediate, you get billed as soon as it starts
- Specify:
    - The Availability Zone in which to reserve the capacity
    - The number of instances for which to reserve capacity
    - The instance attributes, including the instance type tenancy, and platform/OS
- Combine with REserved Instances and Savings Plans to do cost saving
# EC2 Instance Storage Section
## What’s an EBS Volume?
- An EBS (Elastic Block Store) Volume is a network drive you can attack to your instances while they run
- It allows your instances to persist data, even after their termination
- They can only be mounted to one instance at a time (at the CCP level)
- They are bound to a specific availability zone
- Analogy Think of them as a "network USB stick"
- Free tier: 30 GB of free EBS storage of type General Purpose (SSD) or Magnetic per month
## EBS Volume
- It's a network drive
    - It uses the network to communicate the instance, which means there might be a bit of latency
    - It can be detached from an EC2 instance and attached to another one quickly
- It's locked to an Availability Zone
    - An EBS volume in us-east-1 a cannot be attached to us-east-1 b
    - To move a volume across, you first need to snapshot it
- Have a provisioned capacity (size in GBs, and IOPS)
    - You get billed for all the provisioned capacity
    - You can increase the capacity of the drive over time
![EBS Volume](https://imgdb.net/7553 "EBS Volume")
## EBS – Delete on Termination attribute
- Controls the EBS behaviour when an EC2 instance terminates
    - By default, the root EBS volume is deleted (attribute enabled)
    - By default, any other attached EBS volume is not deleted (attribute disabled)
- This can be controlled by thw AWS console / AWS CLI
- Use case: preserve root volume when instance is terminated
## EBS Snapshots
- Make a backup (snapshot) of your EBS volume at a point in time
- Not necessary to detach volume to do snapshot, but recommended
- Can copy snapshots across AZ or Region
## EBS Snapshots Features
- EBS Snapshot Archive
    - Move a snapshot to an "archive tier" that is 75% cheaper
    - Takes within 24 to 72 hours for restoring the archive
- Recycle Bin for EBS Snapshots
    - Setup rules to retain deleted snapshots so you can recover them after an accidental deletion
    - Specify retention (from 1 day to 1 year)
## AMI Overview
- AMI = Amazone Machine Image
- AMI are a customization of an EC2 instance
    - You add your own software, configuration, operating system, monitoring...
    - Faster boot / configuration time because all your software is pre-packaged
- AMI are built for a specfic region (and can be copied across regions)
- You can launch EC2 instances from:
    - A Public AMI: AWS provided
    - Your own AMI: you make and maintain them yourself
    - An AWS Marketplace AMI: an AMI someone else made (and potentially sells)
## AMI Process (from an EC2 instance)
- Start an EC2 instance and customize it
- Stop the instance (for data integrity)
- Build an AMI    - this will also create EBS snapshots
- Launch instances from other AMIs
## EC2 Instance Store
- EBS volumes are network drives with good but "limited" performance
- If you need a high performance hardware disk, use EC2 Instance Store
- Better I/O performance
- EC2 Instance Store lose their storage if they're stopped (ephemeral)
- Good for buffer / cache / scratch data / temporary content
- Risk of data loss if hardware fails
- Backups and replication are your responsibility
![Instance Store](https://imgdb.net/7555 "Instance Store")
## EBS Volume Types
- EBS Volumes come in 6 types
    - gp2 / gp3 (SSD): General purpose SSD volumne that balances price and performance for a wide variety of workloads
    - io1 / io2 (SSD) Highest-performance SSD volume for mission critical low latency or high throughput workloads
    - stl (HDD): Low cost HDD volume designed for frequency accessed, throughput-intensive workloads
    - scl (HDD): Lowest cost HDD volume designed for less frequently accessed workloads
    - EBS Volumes are characterized in Size | Throughput | IOPS (I/O Ops Per Sec)
- When in doubt always consult the AWS documentation
- Only gp2/gp3 and io1/io2 can be used as boot volumes
## General Purpose SSD
- Cost effective storage, low-latency
- System boot volumes, Virtual desktops, Development and test environments
- 1 GiB    - 16 TiB
- gp3:
    - Baseline of 3,000 IOPS and throughput of 125 MiB/s
    - Can increase IOPS up to 16,000 and throughput up to 1000 MiB/s independently
- gp2:
    - Small gp2 volumes can burst IOPS to 3,000
    - Size of the volume and IOPS are linked, max IOPS is 16,000
    - 3 IOPS per GB, means at 5,334 GB we are at the max IOPS
## Provisioned IOPS (PIOPS) SSD
- Critical business applications with sustained IOPS performance
- Or applications that need more than 16000 IOPS
- Great for databases workloads (sensitive to storate perf and consistency)
- io1/io2 (4Gib    - 16TB)
    - Max PIOPS: 64,000 for Nitro EC2 instances & 32,000 for other
    - Can increase PIOPS independently from storage size
    - io2 have more durability and more IOPS per GiB (at the same price as io1)
- io2 Block Express (4 GiB – 64 TiB):
    - Sub-millisecond latency
    - Max PIOPS: 256,000 with an IOPS:GiB ratio of 1,000:1
- Supports EBS Multi-attach
## Hard Disk Drives (HDD)
- Cannot be a boot volume
- 125 GB to 16 TB
- Throughput Opitimed HDD (stl)
    - Big Data, Data warehouse, Log processing
    - Max throughput 500 Mib/s    - max IOPS 500
- Cold HDD (scl):
    - For data that is infrequently accessed
    - Scenarios where lowest cost is important
    - Max throughput 250 MiB/s    - max IOPS 250
![Volume Types Summary](https://imgdb.net/7557 "Volume Types Summary")
## EBS Multi-Attach – io1/io2 family
- Attach the same EBS volume to multiple EC2 instances in the same AZ
- Each instance has full read & write permissions to the volume
- Use case:
    - Archieve higher application availability in cluster Linux application
    - Application must manage concurent write operations
- Must use a file system that's cluster-aware (not XFS, EX4, etc...)
![EBS Multi Attach](https://imgdb.net/7558 "EBS Multi Attach")
## EBS Encryption
- When you create an encrypted EBS volume, you get the following
    - Data at rest is encrypted inside the volume
    - All the data in flight moving between the instance and the volume is encrypted
    - All snapshots are encrypted
    - All volumes created from the snapshot
- Encryption and decryption are handled transparently (you have nothing to do)
- Encryption has a minimal impact on latency
- EBS encryption leverages keys from KMS (AES-256)
- Copying an unencrypted snapshot allows encryption
- Snapshots of encrypted volumes are encrypted
## Encryption: encrypt an unencrypted EBS volume
- Create an EBS snapshot of the volume
- Encrypt the EBS snapshot ( using copy )
- Create new ebs volume from the snapshot (the volume will also be encrypted)
- Now you can attach the encrypted volume to the original instance
## Amazon EFS – Elastic File System
- Managed NFS (network file system) that can be mounted on many EC2
- EFS works with EC2 instances in multi-AZ
- Highly available, scalable, expensive (3x gp2), pay per use
![Elastic file system](https://imgdb.net/7559 "Elastice file system")
## Amazon EFS – Elastic File System
- Use cases: content management, web serving, data sharing, Wordpress
- Use NFSv4.1 protocol
- Uses security group to control access to EFS
- Compatible with Linux bases AMI (not windows)
- Encryption at rest using KMS
- POSIX file system (~Linux) that has a standard file API
- File system scales automatically, pay per use, no capacity planning!
## EFS – Performance & Storage Classes
- EFS Scale
    - 1000s of concurrent NFS clients, 10 GB+/s throughput
    - Grow to Petabyte-scale network file system, automatically
- Perfornmance mode (set at EFS creation time)
    - General purpose(default): latency sensitive use cases (web serve, CMS, etc...)
    - Max I/O    - higher latency, throughput, highly parallel (big data, media processing)
- Throughput mode
    - Bursting (1TB = 50Mib/s + brust of up to 100MiB/s)
    - Provisioned: set your throughput regardless of storage size, ex: 1Gib/s for \| TB storage
## EFS – Storage Classes
- Storage Tiers (lifecycle management features    - move file after N days)
    - Standard: for frequently accessed files
    - Infrequent access (EFS-IA): cost to retrieve files, lower price to store. Enable EFS-IA with a lifecycle policy
- Availability and durability
    - Regional: Multi-AZ, great for prod
    - One Zone: One AZ, greate for dev, backup enabled by default, compatible with IA (EFS one Zone-IA)
- Over 90% in cost savings
## EBS vs EFS – Elastic Block Storage
- EBS volumes...
    - Can be attached to only one instance at a time
    - Are locked at the Availability Zone (AZ) level
    - GP2: IO increases if the disk size increases
    - IO1: Can increase IO independently
- To migrate an EBS volume across AZ
    - Take a snapshot
    - Restore the snapshot to another AZ
    - EBS backups use IO and you shouldn't run them while your application is handling a lot of traffic
    - Root EBS Volumes of instances get terminated by default if the EC2 instance get terminated (you can disable that)
## EBS vs EFS – Elastic File System
- Mounting 100s of instances across AZ
- EFS share website files (WordPress)
- Only for Linux Instances (POSIX)
- EFS has a higher price point than EBS
- Can leverage EFS-IA for cost savings
- Availability Zone 1 Availability Zone 2
- Remember: EFS vs EBS vs Instance Store
# AWS Fundamentals – Part II
> Load Balancing, Auto Scaling Groups and EBS Volumes
# Scalability & High Availability
- Scalability means that an application / system can handle greater loads by adapting
- There are two kinds of scalability
    - Vertical scalability
    - Horizontal scalability
- Scalability is linked but different to high availability
- Let's deep dive into the distinction, using a call center as an example
## Vertical saclability
- Vertically scalability means increasing the size of the instance
- For example, you application runs on a t2.micro
- Scaling that application vertically means running it on a t2.large
- Vertical scalability is very common for non distributed systems, such as a database.
- RDS, ElastiCache are service that can scale vertically
- There's uusually a limit to how much you can vertically scale (hardware limit)
## Horizontal Scalability
- Horizontal scalability means increasing the number of instances / systems for your application
- Horizontal scaling implies distributed systems.
- This is very common for web applications / modern applications
- It's easy to horizontally scale thanks the cloud offerings such as Amazon EC2
## High Avaiability
- High availability usually goes hand in hand with horizontal scaling
- High Avaiability means running your application / system in at least 2 data centers(==AZ)
- The goal of high availability can be passive (for RDS Multi AZ for example)
- The high availability can active (for horizontal scaling)
## High Availability & Scalability For EC2
- Vertical Scaling: increase instance size (= scale up / down)
    - From: t2.nano    - 0.5G of RAM, 1 vCPU
    - To: u-12tb1.metal – 12.3 TB of RAM, 448 vCPUs
- Horizontal scaling: Increase number of instances (scale out / in)
    - Auto Scaling Group
    - Load Balancer
- High Availability: Run instances for the same application across multi AZ
    - Auto Scaling group multi AZ
    - Load Balancer multi AZ
## What is load balancing?
- Load Balances are servers that forward traffic to multiple servers downstream
## Why use a load balancer?
- Spread load across multiple downstream instances
- Expose a single point of access DNS to your application
- Seamlessly handle failures of downstream instances
- Do regular health checks to your instances
- Provide SSL termination HTTPS for your websites
- Enforce stickiness with cookies
- High availability across zones
- Separate public traffic from private traffic
## Why use an Elastic Load Balancer?
- An Elastic Load Balancer is a managed load balancer
    - AWS gurantees that it will be working
    - AWS takes care of upgrades, maintenace, high availability
    - AWS provides only a few configuration knobs
- It costs less to setup your own load balancer but it will be a lot more effort on your end
- It is integrated with many AWS offering / services
    - EC2, EC2 auto scaling groups, amazone ECS
    - AWS Certificate Manager (ACM), CloudWatch
    - Route 53, AWS WAF, AWS Global Accelerator
## Why use an Elastic Load Balancer?
- An Elastic load balancer is a managed load balancer
    - AWS guarantees that it will be wroking
    - AWS takes care of upgrades, maintaince, high vailability
    - AWS provides only a few configuration knobs
- It costs less to setup your own load balancer but it will be a lot more effort on your end
- It is integrated with many AWS offering / services
    - EC2, EC2 Auto scaling groups, amazon ECS
    - AWS Certificate Manager (ACM), CloudWatch
    - Route 53, AWS WAF, AWS Global Accelerator
## Health Checks
- Health checks are crucial for load balancers
- They enable the load balancer to know if instances it forwards traffic to are available to reply to requests
- The health check is done on a prt and a route (/health is common)
- If the response is not 200 (OK), then the instance is unhealthy
## TYpes of load balancer on AWS
- AWS has 4 kind of managed load balancers
- Classic Load Balancer (v1    - old generation)    - 2009    - CLB
    - HTTP, HTTPS, TCP, SSL (secure TCP)
- Application load balancer (v2-new generation)    - 2016    - ALB
    - HTTP, HTTPS, Web Socket
- Network load balancer (v2    - new generation)    - 2017    - NLB
    - TCP, TLS (secure TCP), UDP
- Gateway load balancer    - 202    -GWLB
    - Operates at layer 3 (Network layer)    - IP Protocol
- Overall, It is recommended to use the newer generation load balancers as they provide more features
- Some load balancers can setup as internal or external ELBs
## Classic Load Balancers (v1)
- Supports TCP (layer 4), HTTP & **HTTPS (layer 7)**
- Health checks are TCP or HTTP based
- Fixed hostname XXX.region.elb.amazoneaws.com
## Application Load Balancer (v2)
- Application load balancers is **layer 7 (HTTP)**
- Load balancing to multiple applications on the same machine
- Support for HTTP/2 and websocket
- Support redirects (from HTTP to HTTPS for example)
## Application load balancer (v2)
- Routing tables to different target groups
    - Routing based on path in URL
    - based on Hostname in URL
    - based on query string headers
- ALB are a great fit for micro services & container-based application
- Has a port mapping feature to redirect to a dynamic port in ECS
- In comparison, we'd need multiple classic load balancer per application
![Application Load Balancer (v2) HTTP Based Traffic](https://imgdb.net/7572 "HTTP BAsed Traffic")
## Application Load Balancer (v2) Target Groups
- EC2 instances (can be managed by an Auto Scaling Group) - HTTP
- ECS tasks (managed by ECS itself) - HTTP
- Lamba functions - HTTP request is transalted into a JSON event
- IP Addresses - must be private IPs
- ALB can route to multiple target groups
- Health checks are at the target group level
- ![Application Load Balancer (v2) Query Strings/Parameters Routing](https://imgdb.net/7573 "Query Strings/Parameters Routing")
## Application Load Balancer (v2) Good to Know
- Fixed hostname (XXX.region.elb.amazoneaws.com)
- The application servers dont see the IP of the client directly
 - The true IP of the client is inserted in the header X-FORWARDED-For
 - We can also get Port (X-Forwarded-Port) and proto (X-Forwarded-Proto)
## Network Load Balancer (v2)
- Network load balancers (layer 4) allow to:
 - Forward TCP & UDP traffic to your instances
 - Handle milions of request per seconds
 - Less latency ~ 100ms (vs 400 ms for ALB)
- NLB has one static Ip per AZ, and supports assigning Elastic IP(helpful for whitelisting specific IP)
- NLB are used for extreme performance, TCP or UDP traffic
- Not included in the AWS free tier
## Network load balancer (v2) TCP (layer 4) based traffic
![Based traffic](https://imgdb.net/7574 "based on traffic")
## Network Load Balancer – Target Groups
- EC2 instance
- IP Address - must be private IPs
- Application load balancer
## Gateway Load Balancer
- Deploy, scale, and manage a fleet of 3 party network virtual appliances in AWS
- Example: Firewalls, Instrusion detection and prevention systems, deep packet inspection systems, payload manipulation, ...
- Operates at layer 3 (Network layer) Ip packets
- Combines the following functions:
 - Transparent Network Gateway: single entry/exit for all traffic
 - Load Balancer: distributes traffic to your virtual appliances
- Uses the Geneve protocol on port 6081
## GAteway load balancer - Target Groups
- EC2 instances
- IP Addresses - must be private IPs
## Sticky Sessions (Session Affinity)
- It is possible to implement stickiness so that the same client is always redirected to the same instances behind a load balancer
- This works for classic load balancers & application load balancers
- The "cookie" used for stickiness has an expiration date you control
- Use case: make sure the use doesn't lost his session data
- Enabling stickiness may bring imbalance to the load over the backend EC2 instances
## Sticky Sessions - Cookie Names
- Application-based Cookies
    - Custom cookie
    - Can include any custom attributes required by the application
    - Cookie name must be specified individually for each target group
    - Don't use AWSALB.AWSALBTB (reserved for use by the ELB)
- Application cookie
    - Generated by the load balancer
    - Cookie name is AWSALBAPP
- Duration based cookies
    - Cookie generated by the load balancer
    - Cookie name is AWSALB for ALB, AWSELB for CLB
## Cross-Zone Load Balancing
- With Cross-Zone Load Balancing: Each load balancer instance distributes evently across all registered instances in all AZ
- Without Cross zone load balancing: Request are distributed in the instances of the node of the elastic load balancer
## Cross-Zone Load Balancing
- Application load balancer
    - Always on (can't be disabled)
    - No charges for inter AZ data
- Network Load Balancer
    - Disabled by default
    - you pay charge($) for inter AZ data if enabled
- Classic Load Balancer
    - Disabled by default
    - No charges for inter AZ data if enabled
## High Availability (HA)
aims to ensure an agreed level of operational performance ussually uptime, for a higher than normal period.
- 99.9%(Three 9's) = 8.77 hours p/year downtime
- 99.999%(Five 9's) = 5.26 minutes p/year downtime
- aims zero downtime
- Minimise any outages
## Fault-Tolerance (FT)
- is the property that enables a system to continue operating properly in the event of the failure of some (one or more faults within) of its components
- Systems design with plan fault tolerance
- Operate through faults
## Disater recovery(DR)
- a set of polocies, tools and procedures to **enable the recovery** or **continuation** of vital technology infrastructure and systems following a natural or human-inclued disaster
- Pre planning --------------------> DR Process
- Used when these don't work
	![](https://ibb.co/TY6Mhtm)
	
	# Classic Solutions Architecture
## Section Introduction
- These solutions architectures are the best part of this course
- Let's understand how all the technologies we've seen work together
- This is a section you need to be 100% comfortable with
- We'll see the progression of a Solution's architect mindset through many sample case studies:
    - WhatIsTheTime.Com
    - MyClothes.Com
    - MyWordPress.Com
    - Instantiating applications quickly
    - Beanstalk
## Stateless Web App: WhatIsTheTime.com
- WhatIsTheTime.com allows people to know what time it is
- We don’t need a database
- We want to start small and can accept downtime
- We want to fully scale vertically and horizontally, no downtime
- Let’s go through the Solutions Architect journey for this app
- Let’s see how we can proceed!
## Stateless web app: What time is it? Starting simple
![](https://imgdb.net/storage/uploads/3f1281a36220c72f5dcadc031d0b36773c146604a91b2ea9832a49ea6b7cb43c.png)
## Stateless web app: What time is it? Scaling vertically
![](https://imgdb.net/storage/uploads/48552f1cb1d38f22696488a782e1b72482b269d85a6318dd096050baf407518d.png)
## Stateless web app: What time is it? Scaling horizontally
![](https://imgdb.net/storage/uploads/be45fc039578ede45694b18ba6afb10a1d24823a5df87c5eb903e3997847b569.png)
## Stateless web app: What time is it? Scaling horizontally
![](https://imgdb.net/storage/uploads/ac2fde429ee06cd9c2b03e3797e2cbf189bdbfc2ce4c19d3054fee7b2190f5aa.png)
## Stateless web app: What time is it? Scaling horizontally, adding and removing instances
![](https://imgdb.net/storage/uploads/800e3afd13b9dc55f99d3a88e18c683232f440bcd2a83341be7f3853ddce39f5.png)
## Stateless web app: What time is it? Scaling horizontally, with a load balancer
![](https://imgdb.net/storage/uploads/000046745e3a3ac4b6e11a89c8c50dda405e4449c07e081b766d46099e480fae.png)
## Stateless web app: What time is it? Scaling horizontally, with an auto-scaling group
![](https://imgdb.net/storage/uploads/2a4b112c37d56a997ecf56511ae2a219155293add80f93d741e5af2cdabc1185.png)
## Stateless web app: What time is it? Making our app multi-AZ
![](https://imgdb.net/storage/uploads/1ea054d39476bf2043c2c96ea1cb2a7511f496001c617e497af3e28726bdbb72.png)
## Minimum 2 AZ => Let’s reserve capacity
![](https://imgdb.net/storage/uploads/c257dfb6fa0fe97806842c16916811b45b01159204b45ae88ef232e47fe6962e.png)
## In this lecture we’ve discussed…
- PUblic vs Private IP and EC2 instances
- Elastic IP vs Route 53 vs Load Balancers
- Route 53 TTL, A records and Alias Records
- Maintaining EC2 instances manually vs Auto Scaling Groups
- Multi AZ to survive disasters
- ELB health Checks
- Security GRoup Rules
- Reservation of capacity for costing saving when possible
- We're considering 5 pillars for a well architected application: costs, performance, reliability, security, operational excellence
## Stateful Web App: MyClothes.com
- MyClothes.com allows people to buy clothes online.
- There’s a shopping cart
- Our website is having hundreds of users at the same time
- We need to scale, maintain horizontal scalability and keep our web application as stateless as possible
- Users should not lose their shopping cart
- Users should have their details (address, etc) in a database
- Let’s see how we can proceed!
## Stateful Web App: MyClothes.com
![](https://imgdb.net/storage/uploads/32b1f46e76f5194a59484cf8431bb905ae847053b38151a6710cbcb0ce696914.png)
## Stateful Web App: MyClothes.com Introduce Stickiness (**Session Affinity**)
![](https://imgdb.net/storage/uploads/d15c8884a5ca0bd506448b56551eb44e9015fde9a1f613f4d73450f973e8244f.png)
## Stateful Web App: MyClothes.com Introduce User Cookies
![](https://imgdb.net/storage/uploads/a7abacd4948a549e408abaae029a78472d3e7db0dbc3d03c6661c87c50b52dcf.png)
## Stateful Web App: MyClothes.com Storing User Data in a database
![](https://imgdb.net/storage/uploads/b188d9be8d4b277010e16d38a77341400983ac43524e5b039129b0a14a95e114.png)
## Stateful Web App: MyClothes.com Scaling Reads
![](https://imgdb.net/storage/uploads/12f6959c537f7953d73d17fd2f90cd443d81978bcc921400d7e8d4d7e3742de9.png)
## Stateful Web App: MyClothes.com Scaling Reads (Alternative) – Write Through
![](https://imgdb.net/storage/uploads/09805153c5bec018cd04763a7a601cf05e862dde7b7c242cfeb39453218a5df5.png)
## Stateful Web App: MyClothes.com Multi AZ – Survive disasters
![](https://imgdb.net/storage/uploads/f53a9b6ea47d87ac3924cc962d408c1c444d9863467268d21c8f9f480b90d13e.png)
## Stateful Web App: MyClothes.com Security Groups
![](https://imgdb.net/storage/uploads/3fe702ebb99a48b268ad0d023b04477522d800898e38d342d06e19b0930de9f7.png)
## In this lecture we’ve discussed… 3-tier architectures for web applications
- ELB sticky sessions
- Web clients for storing cookies and making our web app sateless
- ElasticCache
    - For storing sessions (alternative: dynamoDB)
    - For caching data from RDS
    - Multi AZ
- RDS
    - For storing user data
    - Read replicas for caling reads
    - Multi AZ for disaster recovery
- Tigh Security with security groups referencing each other
## Stateful Web App: MyWordPress.com
- We are trying to create a fully scalable WordPress website
- We want that website to access and correctly display picture uploads
- Our user data, and the blog content should be stored in a MySQL database
- Let’s see how we can achieve this!
## Stateful Web App: MyWordPress.com RDS layer
![](https://imgdb.net/storage/uploads/bcc9f2ce6247cdada7016ad997ae154615315e19aeded4838bfc91ca74038d37.png)
## Stateful Web App: MyWordPress.com Scaling with Aurora: Multi AZ & Read Replicas
![](https://imgdb.net/storage/uploads/7869aa0e8550ea2fba2cd787d75ff80ffb8b6817ab5a9e253a56d3c367613b97.png)
## Stateful Web App: MyWordPress.com Storing images with EBS
![](https://imgdb.net/storage/uploads/995d9336c2bfb1c483d8c024a015d8c7c79a48f6749eff56339efb3907092f61.png)
## Stateful Web App: MyWordPress.com Storing images with EBS
![](https://imgdb.net/storage/uploads/432996262b19c001f8b7d5c1b71523e3ec83040f995c6ef42ffa07000215a38c.png)
## Stateful Web App: MyWordPress.com Storing images with EFS
![](https://imgdb.net/storage/uploads/e18604de4215ca2138440a1c334b1092a9393578075a0a9b62dd6a35c5d8baf7.png)
## In this lecture we’ve discussed…
- Aurora Database to have easy Multi-AZ and Read-Replicas
- Storing data in EBS (single instance application)
- Vs Storing data in EFS (distributed application)
## Instantiating Applications quickly
- When launching a full stack (EC2, EBS, RDS), it can take time to:
    - Install applications
    - Insert initial (or recovery) data
    - Configure everything
    - Launch the application
- We can take advantage of the cloud to speed that up!
## Instantiating Applications quickly
- EC2 Instances:
    - Use a Golden AMI: Install your applications, OS dependencies etc.. beforehand and launch your EC2 instance from the Golden AMI
    - Bootstrap using User Data: For dynamic configuration, use User Data scripts
    - Hybrid: mix Gloden AMI and user Data (Elastic Beanstalk)
- RDS Databases:
    - Restore from a snapshot the database will have schemas and data ready!
- EBS Volumes:
    - Restore from a snapshot: the disk will already be formatted and have data!
## Typical architecture: Web App 3-tier
![](https://imgdb.net/storage/uploads/963e0d2b28ac9b442ebfac34b1bfc7724cba187d3384c78f2f2fd8a885107fae.png)
## Developer problems on AWS
- Manging infrastructure
- Deploying Code
- Configuring all the databases, load balancers, etc
- Scaling concerns
- Most web apps have the same architecture (ALB + ASG)
- All the developers want is for their code to run!
- Possibly, consistency across different applications and environments
## Elastic Beanstalk - Overview
- Elastic Beantalk is a developer centric view of delpoying an application on AWS
- It uses all the component's we've seen before: EC2, ASG, ELB, RDS, ...
- Managed service:
    - Automatically handles capacity provisoning, load balancing, scaling, application health monitoring, instance configuration, ...
    - Just the application code is the responsibility of the developer
- We still have full control over the configuration
- Beanstalk is free but you pay for the underlying instances
## Elastic Beanstalk – Components
- Application: collection of ElasticBeantalk components (environments, versions, configurations, ...)
- Application version: an iteration of your application code
- Environment
    - Collection of AWS resources running an application version (only one application version at a time)
    - Tiers: Web Server Environment Tier & Workerd Environment Tier
    - you can create multiple environment (dev, test, prod)
![](https://imgdb.net/storage/uploads/78d84e9b24970b1d5d6409c7847f6d15cec0b600fcb537a9ef893f3fceb843e9.png)
## Elastic Beanstalk – Supported Platforms
- Go
- Java SE
- Java with Tomcat
- .NET Core on Linux
- .NET on Windows Server
- Node.js
- PHP
- Python
- Ruby
- Packer Builder
- Single Container Docker
- Multi-container Docker
- Preconfigured Docker
- If not supported, you can write
your custom platform (advanced)
## Web Server Tier vs. Worker Tier
![](https://imgdb.net/storage/uploads/d449e7e6c294d0153fb0ed63671de2e8298b67b2d68987db69de7da4e5053b53.png)
