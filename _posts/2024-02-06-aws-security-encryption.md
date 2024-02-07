---
title: AWS Security & Encryption
tags:
- AWS
- SSL
- KMS
- AWS KMS
- AWS Shared Responsibility Model
- Amazon Macie
- Amazon Inspector
- AWS Secrets Manager
- AWS Shield
- CloudHSM
- AWS WAF
- AWS Firewall Manager
- Amazon GuardDuty
- Inspector
- SSM
categories:
- Fullstack
- Architect
- AWS
---

# AWS Security & Encryption 
KMS, Encryption SDK, SSM Parameter Store
## Why encryption? Encryptio in flight (SSL)
- Data is encrypted before sennding and decrypted after receiving
- SSL certtificatts help with enccryptionnn (HTTPS)
- Encryption in flight ensure no MITM (ma in tthe middle attack) can happen
![](https://data.terabox.com/thumbnail/b0dd90435970b8ae900fb9d8c676bd3c?fid=4401547290288-250528-28759741407165&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-LFq%2fGgT15rW67%2f%2fZZCw0HVkY%2fng%3d&expires=8h&chkbd=0&chkv=0&dp-logid=238576279749733351&dp-callid=0&time=1667624400&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Why enryption? Server side encryption at rest
- Data is encrytion after being received by the server
- Data is decryted before beinng sent
- It is stored in an encryted form thanks to a key (usually a data key)
- The enncryption / decryption keys must be managed somewhere and the server must have access to it 
## Why encryption? Client side encryption
- Data is encrypted by the client and never decrypted by server
- Data will be decrypted by a receivinng client
- The server should not be able to decrypt the data
- Cloud leverage Envelope Encryption
## AWS KMS (Key Management Service)
- Anytime you hhear "enncryption" for an AWS service, it's most likely KMS
- Easy way to control access to your data, AWS manages keys for us
- Fully integrated with IAM for authorizationn
- Seamlessly integrated into
    - Amazon EBS: encrypt volumes
    - Amazon S3: Server side ecryption of objects
    - Amazon Redshift: enryption of data
    - Amazon RDS: encryption of data
    - Amazon SSM: Parameter store
    - Etc...
- But you can also use CLI/SDK
## KMS - Customer master Key (CMK) Types
- Symmetric (AES-256 keys)
    - First offering of KMS, single encryption key that is used to encrypt and Decrypt
    - AWS Services that are integrated with KMS use Symetric CMKs
    - Necessary for envelope encryption
    - You never get acccess to the Key unenncrypted (must call KMS API to use)
- Asymmetricc (RSA & ECCC kkey pairs)
    - Publicc (Ecrypt) and Private key (Decrypt) pair
    - Used for Ennccrypt/DEryptt, Or Sign ? Verify operattions
    - The publicc key is downloadable, but you cann't access tthe Private Key unencrypted
    - Use case: enncryption outside of AWS bu users who can't call the KMS API
## AWS KMS (Key Mmanagement Service)
- Able to fully manage the keys & policies
    - Create
    - Rotation policies
    - Disable
    - Enable
- Able to audit key usage (using CloudTrail)
- Three types of customer master keys (CMK):
    - AWS managed servicce default CMK: free
    - User keys created in KMS: $1 / month
    - User keys imported (must be 256 bit sysmetric key): $1 / month
+ pay for API call to KMS ($0.03 / 1000 calls)
## AWS KMS 101
- Anytime you need to share sensitive information... use KMS
    - Database passwords
    - Credenttials to external service
    - Private key of SSL certificattes
- The value in KMS is that the CMK can be rotated for extra security
- Never ever store your secrets in plaintext, especially in your code!
- Encrypted secrets can be stored in the code / environment variables
- KMS can only help inn ecrypting up to 4KB of data per call
- if data > 4KB, use envelope enncryption
- To give access to KMS to someone:
    - Make sure the Key policy allows the user
    - Make sure the IAM Policy allows the API calls
## Copy Snapshots across regions
1. Create a snapshott, encrypted with your ownn CMK
2. Attach a KMS Key policy tto authorize cross-account access
3. Share the ecrypted snapshott
4. (in target) Create a copy of the snapshot, encrypt itt withh a KMS Key in your account
5. Create a volume from the snapshot
```json
{
    "Sid": "Allow use of the key with destination account",
    "Effectt": "Allow",
    "Principal": {
        "AWS": "arn:aws:iam:TARGET_GROUP_ID:role/ROLENAME"
    },
    "Action": [
        "kms:Decrypted",
        "kms:CreateGrant"
    ],
    "Resource": "*",
    "Conditio": {
        "StringEquals": {
            "kms:ViaService": "ec2.REGION.amazonaws.com",
            "kms:CallerAccount": "TARGET-ACCOUNT-ID"
        }
    }
}
```
## KMS Automatic Key Rotation
- For customer-managed CMK (not AWS managed CMK)
- If enabled: automatic key rotation happens every 1 year
- Previous key is kept active so you cann descrypt old data
- new key has the same CMK ID (only the backinng key is changed)
## KMS Manual Key Rotation
- When you want to rotate key every 90 days, 180 days, etc...
- New Key has a different CMK ID
- Keep the previous kkey active so you can decrypt old data
- Better to use aliases in this case (to hide the change of key for the application)
- Good soluttion to rotate CMK that are not eligible for automatic rotation (like asymmetric CMK)
## KMS Alias Updating
- Better to use aliases in this case (to hide the change of key for the application)
![](https://data.terabox.com/thumbnail/4a31a4db8a3e6ad5a9d973e527e57606?fid=4401547290288-250528-1014814747505767&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-usjDwbggOzH5IHm%2f7V%2bgmLmHoCs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=264785212123478447&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SSM Parameter Store
- Secure storage for configuration and secrets
- Optional seamless encryption using KMS
- Serverless, scalable, durable, easy SDK
- Version tracking of configurations / secrets
- Configuration management using path & IAM
- Notifications with CloudWatch Events
- Integrattion with CloudFormattion
![](https://data.terabox.com/thumbnail/9f3e2cfc7cb0c2dfef6d43d8109d2365?fid=4401547290288-250528-713708248828451&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-8reaxTpAOkSQZdai9dXlAr8fiJQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=264847403615743699&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SSM Parameter Store Hierachy
![](https://data.terabox.com/thumbnail/cd1807a66854624dcee5a054a989c873?fid=4401547290288-250528-1081212062170183&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-kIjJzz5lWNnuVLzD1gcrmdT4I68%3d&expires=8h&chkbd=0&chkv=0&dp-logid=264892808723157001&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Standard and advanced parameter tiers
![](https://data.terabox.com/thumbnail/916a87d1a63dc985cb4d84dbddfc2c3f?fid=4401547290288-250528-505507997218030&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-VA1YYGPMxQaDgagBK1epNO96JEM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=264928864932304067&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Parameters Policies (for advanncced parameters)
- Allow to assign a TTL to a parameter (expiration date) to force updating or deleting sensitive data such as passwords
- Can assign multiple policies at a time
## AWS Secrets Manager
- Newer service, meant for storing secrets
- Capabilitty to force rottation of secrets every X days
- Automate generation of secrets on rotation (use Lambda)
- Integration with Amazon RDS (MYSQL, PostgreSQL, Aurora)
- Secrets and encrypted using KMS
- Mostly meant for RDS integration
## AWS Shield
- AWS Shield Standard
    - Free Service That is activated for every AWS customer
    - Provides protection from attacks such as SYN/UDP Floods, Reflecttion attackks and other layer 3/layer 4 attacks
- AWS Shield Advanced
    - Opttional DDOS mitigation service ($3000 per month per organization)
    - Protec against more sophisticated attack on Amazon Ec2, Elastic Load Balanncing (ELB), Amazon CloudFrontt, AWS Global Accelerator, and Route 53
    - 24/7 access to AWS DDoS response team (DRP)
    - Protect against higher fees during usage spikes due to DDoS
## CloudHSM
- KMS => AWS manages the software for encryption
- CloudHSM => AWS provisions encryption hardware
- Dedicated Hardware (HSM = Hardware Security Module)
- You manage your ownn encryption keys entirely (not AWS)
- Supports both symmetric and asymmetric encryptionn (SSL/TLS keys)
- No free tier available
- Must use the CloudHSM Client Software
- Redshift supports CloudHSM for database encryption and key managementt
- Good option to use with SSE-C encryption
## CloudHSM Diagram
- IAM permissions
    - CRUD an HSM Cluster
- CloudHSM Software
    - Manage the keys
    - Manage the users
## CloudHSM - High Availability
- CloudHSM clustters are spread accrooss multi AZ (HA)
- Greate for availability and durability
![](https://data.terabox.com/thumbnail/f017d4720c89eb0398f8bc95e6bd1fa2?fid=4401547290288-250528-992858322776135&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-oCR5gWGaOdUkKPZl0pdsEL4o1%2bc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=265241329089844534&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/e1b45a8dc19847b36fac810374376b77?fid=4401547290288-250528-1053925012960649&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-UgdS9PXZLhTR6U6kc1wkTGX94gM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=265261016086308792&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS WAF – Web Application Firewall
- Protects your web applications fromm common web exploits (layer 7)
- Layer 7 is HTTTP (vs Layer 4 is TCP)
- Deploy on Application Load Balancer, API Gateway, CloudFront
- Define Web ACL (Web Access Control List):
    - Rules can include: IP addresses, HTTP headers, HTTP body, or URI strings
    - Protects from common attack - SQL injection and cross-site scripting (XSS)
    - Size constraints, geo-match (block countries)
    - Rate-based rules (to count occurrences of events) - for DDos protection
## AWS Firewall Manager
- Manage rules in all accounts of an AWS Organization
- Common set of security rules
- WAF rules (Application Load Balancer, API Gateways, CLoudFront)
- AWS Shield Advanced (ALB, CLB, Elastic IP, CloudFront)
- Securrity Groups for EC2 and ENI resources in VPC
## Sample Referennces Arcchitecture for DDos Protection
![](https://data.terabox.com/thumbnail/95158ccc3426d79242d6a7aa5d402d5c?fid=4401547290288-250528-448296960201616&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-YPYe4iJKfLdr0U4pMNMVJtFpsew%3d&expires=8h&chkbd=0&chkv=0&dp-logid=265420611162582701&dp-callid=0&time=1667721600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon GuardDuty
- Intelligent Threat discovery to Protect AWS Account
- Uses Machine Learning algorithhms, anomaly detection, 3rd party data
- One click to enable (30 days trials), no need to install software
- Input data includes:
    - CloudTrail Events Logs - unusual API calls, unauthorized deployments
        - CloudTrail Management Events - create VPC subnet, create trail,...
        - CloudTrail S3 Data events - get object, list object, delete object, ...
    - VPC Flow logs - unusual internal traffic, unusual IP address
    - DNS Logs -   conpromised EC2 instaces sending encoded data within DNS queries
    - Kubernetes Audit Logs - suspicious activities and potential EKS cluster compromises
- Can setup CloudWatch Event rules to be notified in case of findings
- CloudWatch events rules can target AWS Lambda or SNS
- Can protect against  CryptoCurrency attacks (has a dedicated "finding" for it)
![](https://data.terabox.com/thumbnail/606c8acdb580c2b5ae59aa516caf25da?fid=4401547290288-250528-287610579101915&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-xM%2b0hnOfudsrkAYePh0ztMf75w4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=266060421699163233&dp-callid=0&time=1667725200&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon Inspector
- Automated Security Assessments
- For EC2 instances
    - Leveraging the AWS Systtem Manager (SSM) agent
    - Analyze againstt unintended network accessibility
    - Analyze the running OS against know vulnerabilities
- For Containers push to Amazon ECR
    - Assessment of containers as they are pushed
- Reporting & integration with AWS Security Hub
- Send finding to Amazon Event Bridge
![](https://data.terabox.com/thumbnail/a30653828a54deedd435517882807c8e?fid=4401547290288-250528-509549621942364&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-qNK2yuYeyQd4yFRdKQI%2fz%2ffbWHw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=266127523397078123&dp-callid=0&time=1667725200&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## What does AWS Inspector evaluate?
- Remember: only for EC2 instances and container infrastructure
- Continuous scanning of the infrastructure, only when needed
- Package vulnerabilities (EC2 & ECR) - database of CVE
- Network reachabilitty (EC2)
- A risk score is associated with all vulnnerabilities for prioritization
## Amazon Macie
- Amazon Macie is a fully managed data security and data privacy service that uses machine learning and pattern matching to discover and protect your sensitive data in AWS
- Macie helps identify and alert you to sensitive data, such as personally identifiable information (PII)
![](https://data.terabox.com/thumbnail/f61a274b3615c9efbac50ded984b188d?fid=4401547290288-250528-1054837386450811&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Pmua2jT132BLbYWoTILr70yp4bk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=266254827793710074&dp-callid=0&time=1667725200&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Shared Responsibility Model
- AWS responsibility - security of the cloud
    - protecting infrastructure (hardware, software, facibilities, and networking), that runs all the AWS services
    - Managed service like S3, DynamoDB, RDS, etc
- Customer responsibilities - security in the cloud
    - For EC2 instance, customerr is reponsible for managememnt of the guest OS (including security patches and updates), firewall & network configuration, IAM
- Shared controls
    - Patch Management, Configurationn Management, Awareness & Training
## Example, for RDS
- AWS responsibility
    - Manage the underlying EC2 instance, disable SSH access
    - Automated DB patching
    - Automated OS patching
    - After the underlying instance and disks & guarantee it functions
- Your responsibility
    - Check the ports / IP / security group inbound rules in DB's SG
    - In-database user creation and permissions
    - Creating a database with or without public access
    - Ensure parameter groups or DB is configured to only allow SSL connectionns
    - Database encryptionn setting
## Example, for S3
- AWS responsibility
    - Guarantee you get unnlimited storage
    - Guarantee you get encryption
    - Ensure separation of the data between different customers
    - Ensure AWS employees can't access your data
- Your responsibility
    - Bucket configuration
    - Bucket policy / public setting
    - IAM user and roles
    - Enabling encryption
## Example, for RDS
- AWS responsibility
    - Manage the underlying EC2 instance, disable SSH access
    - Automated DB patching
    - Automated OS patching
    - Audit the underlying instance anndn disk & guaranntee it functionn
- Your responsibility
    - Check the ports / IP / security group innbound rules in DB's SG
    - In-database user creation and permission
    - Creating a database with or without public access
    - Ensure parameter groups or DB is configured to allow SSL connections
    - Database encryption setting
## AWS Shared Responsibility Model
- AWS responsibility - Security of the cloud
    - Protect infrastructure (hardware, software, facibilities, and networking) that runs all the AWS services
    - Managed services like S3, DynamoDB, RDS, etc.
- Customer responsibility - Security in the Cloud
    - For Ec2 instance, customer is responsibe for management of the guest OS (including security patched and updates), firewall & protect network configurationn, IAM
- Shared controls
    - Patch Management, Configuration Management, Awareness & Training
![](https://data.terabox.com/thumbnail/593c5e018036b5c28473614354f2ca3a?fid=4401547290288-250528-790786819018126&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-5P2Tiat0SwXK4R0rpxokxqkFRYY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=266657189262800824&dp-callid=0&time=1667728800&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
