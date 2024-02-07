---
tags:
- aws
- architecture
- fullstack
- s3
- Glacier
- EFS
- FSx
- EBS
- kms
- database
- Snow family
- CloudFront
- InstanceStorage
- StorageGateway
title: 'AWS S3 and AWS Storage Gateway Services:'
categories:
- Fullstack
- Architect
- AWS
---

# Advannce S3
## S3 MFA Delete
- MFA (mutil factor authentication) forces uses to genenrate a code in a device (usually a mobile phone or hardware) before doing important operation on S3
- To use MFA-Delete, enable versioninng on the S3 bucket    
- You will eed MFA to
    - permanetly delete ann object versio
    - susped versioing on the bucket 
- You won't need MFA for
    - enabling versionnig
    - listing deleted versions
- Only the bucket owner (root account) can eable/disab;e MFA delete
- MFA-Delete currently can only enabled using CLI
## S3 Default Encryption vs Bucket Policies 
- One way tp "force encryption" is to use a bucket policy ad refuse any API ccall to PUT a S3 object without encryption headers:
- Another way is to use the "default ecryption" option in S3
- Note: Bucket Policies are evaluated before "default encryption"
## S3 Access Logs
- For audit purpose, you may want to log all access to S3 buckets
- Any request made to S3, from any accout, authorized or denied, will be logged into aother S3 bucket
- That data can be analyzed using data analysis tools...
- Or Amazon Athena as we'll see later i this secction 
## S3 Access Logs: Warning
- Do not set your logging bucket to be the monitored bucket
- It will create a logging loop, and your bucket will grow in size exponetially
## S3 Replication (CRR & SRR)
- Must enable versioing in source and destiation
- Cross Region Repliccationn (CRR)
- Same Region Replication (SRR)
- Buckets ca be in different accounts
- copying is asynchronous
- Must give proper IAM permissions to S3
- CRR - Use cases: compliancce, lower latency access, replicatio across acccounts
- SRR - Use ccases: log aggregatio, live replication between production annd test accounnts
## S3 Replication - Notes
- After activating, onnly new objects are replicated
- Optioally, you can replicate existing objects usig S3 batch replication
    - Replicates existing objects and objects that failed replication
- For DELETE operationns:
    - Can replicate delete markers from source to target (optional settinng)
    - Deleteions with a version ID are not replicated (to avoid malicious deletes)
- There is no "chaining" of replication
    - If bucket I replcatio into bicket 2, which has replication into bucket 3
    - Then object create inn bucket I are not replicated to bucket 3
## S3 Pre-Signed URLs
- Cann generate pre-signed URLs using SDK or CLI
    - For downloads (easy, can use the CLI)
    - For uploads (harder, must use the SDK)
- Valid for a default of 3600 secods, can change timeout with --expireds-in [TIME_BY_SECONDS] argument
- Users given a pre-signed URL innherit the permissions of the perso who gennerated the Url for GET / PUT
- Examples:
    - Allow only logged-in users to download a premium video on your S3 bucket
    - Allow a ever changing list of users to download files by generatig URLs dynnamically
    - Allow temporarily a user to upload a file to a precise loccation in our bucket
## S3 Storage Classes
- Amazon S3 Standard - Genneral Purpose
- Amazon S3 Stadard-ifrequent Access(IA)
- Amazon S3 One Zone-Infrequent Access
- Amazon S3 Glacier Instant Retrieval
- Amazon S3 Glacier Flexible Retrieval
- Amazo S3 Glacier Deep Archive
- Amazon S3 Intelligent Tierinng
- Can move betwee classes maually or using S3 lifecycle cofigurations
## S3 Durability and Availability
- Durability
    - High durability (99,999999999% || 9's) of objects across multiple AZ
    - If you store 10.000.000 objects with Amazon S3, you ccan on average expect to incur a loss of a single object once every 10.000 years
    - Same for all storage classes
- Availability
    - Measures how readily available a service is
    - Varies depedig o storage class
    - Example: S3 standard has 99.99% availability = not avaiable 53 minutes a year
## S3 Standard - General Purpose
- 99.99% Availability
- Used for frequently accessed data
- Low latenccy annd high throughput
- Sustai 2 concurennt faccility failures
- Use CAses: Big Data analytics, mobile & gaming appliccations, conntet distribution...
## S3 Storage Classes - Innfrequent Access
- For data that is less frequently accessed, but requires rapid access when needed
- Lower cost than S3 Standard
- Amazon S3 Standard- Ifreqeunt Access (S3 Standard-IA)
    - 99.9% Availability
    - Use cases: Disaster recovery, backups
- Amazon S3 Oe Zonne-Infrequet Acccess (S3 One Zone-IA)
    - High durability (99.999999999%) in a sigle AZ; data lost when AZ is destroyed
    - 99.5% Availability
    - Use Cases: Storing secodary backup copies of on-premises data, or data you cann recreate
## Amazo S3 Glacier Storage Classes
- Low cost objecct storage meant for archving / backup
- Pricing: pricce for storage + object retrieval cost
- Amazon S3 Glacier Instant Retrieval
    - Milisecond retrieval, greate for data accessed once a quarter
    - Minimum storage duration of 90 days
- Amazon S3 Glacier Fexible Retrieval (formerly Amazon S3 Glacier):
    - Expedited (1 to 5 minutes), Standard (3-5 hours), Bulk (5-12 hours)- free
- Amazon S3 Glaccier Deep Archive - for long term storage
    - Standard (12 hours), Bulk (48 hours)
    - Minimum storage duration of 180 days
## S3 Intelliget-Tiering
- Small mothly moitorig ad auto tierig fee
- Moves objects automatically between Acccess Tiers based on usage
- There are o retrieval charges i S3 Itelliget-Tierig
- Frequet Access tier (automatic): default tier
- ifrequet Access tier (automatic): objet ot accessd for 30days
- Archive Istant Access tier (automatic): object ot accessed for 90days
- Archive Access tier (optioal): configuratio from 90 days to 700+ days
- Deep Arcchive Access tier (optionnal): ccofig, from 180 days to 700+ days
## S3 - Moving between storage classes
- You can transition objeccts betwee storage classes
- For infrequently accessed objecct, move them to STADARD_IA
- For arcchive objects you don't need in real-time, GLACIER or DEEP_ARCHIVE
- Moving objects can be automated using a lifecycle configuration
## S3 Lifecycle rules
- Transition actions: It defines whe objects are transitioned to aother storage class
    - Move objects to Standard IA class 60 days after creatio
    - Move to Glacier for archiving after 6 months
- Expiration actions: configure objects to expire (delete) after some time
    - Access log files can be set to delete after a 365 days
    - Can be used to delete old versions of files (if versioning is enabled)
- Rules can be created for a certai prefix (ex- s3://mybucket/mp3/\*)
- Rules can be created for certain object tags (ex: Departmet Fiancer)
## S3 Lifecycle Rules - Sceario I
- Your applicationn o Ec2 creates images thuhmbails after profile photos are uploaded to Amazon S3. These thumbails can be easily recreated, ad only need to kept for 45 days. The source images should be able to be immediately retrieved for these 45 days, and afterwards, the user can wait up to 6 hours. How would you desig this?
- S3 source images can be on STADARD, with a lifecycle configuration to transitionn them to GLACCIER after 45 days.
- S3 thumbnails cann ben o OEZOE_IA, with a lifecycle configurationn to expire them (delete them) after 45 days.es
## S3 Lifecyccle Rules - Scennario 2
- A rule in your company stated that you should be able to recover your deleted S3 objects immediatedly for 15days, although this happen rarely. after this time, and for up to 365 days, deleted objects should be recoverable within 48 hours.
- You need to enable S3 versioning in order to have objecct versions, so thhat "deleted objects" are in fact hidden by a "delete marker" ad ccan be recored
- You can transition these "ocurrent versions" of the object to S3_IA
- You can transition afterwards these "noncurrent versios" to DEEP_ARCHIVE
## S3 Analyticcs - Storage class analysis
- You can setup S3 Abakytics too help determine wheh to trannsition objects from Stadard to Standard_IA
- Does ot work for ONNCCEZONE_IA or GLACIER
- Report is updated daily
- Takes about 24h to 48h hours to first start
- Good first step to put together lifecycle rules (or improve them)!
## S3 Baseline Performace
- Amazon S3 automatically scales to high request rates, latecy 100-200 ms
- Your applicationnn ccan achieve at lease 3500 PUT/COPY/POST/DELETE and 5500 GET/HEAD request per secod per prefix in a bucket.
- There are o limits to the number of prefixes in a bucket
- Example (object path -> prefix):
    - bucket/folder1/sub/file => /folder1/sub1/
- If you spread read across all four prefixes evenly, you can achieve 22000 requests per second for GET and HEAD
## S3 KMS Limitatio
- If you use SSE-KMS, you may be impacted by the KMS limits
- When you upload, it calls the GenerateDataKey KMS API
- When you download, it calls the Deccrypt KMS API
- Cout towards the KMS qouta per seconnd
- You can request a qouta increase usinng the service qoutas console
## S3 Performacce
- Multipart upload
    - recomeded for files > 100MB, must use for files > 5GB
    - can help parallelized uploads (speed up transfers)
- S3 Trasfer Acceleration
    - Increase transfer speed by transferring file to an AWS edge location which will forward the data to the S3 bucket i thhe target region
    - Compatible with multi-part upload
## S3 Performace - S3 Byte Rage Fetches
- Parallelize GETs by requesting specificc byte rages
- Better resiliece in case of failures
## S3 Select & Glacier Select
- Retrieve less data using SQL by performing server side filterig
- Ca filter by rows & columns (simple SQL statemennnts)
- Less network transfer, less CPU cost client-side
## S3 Evet ootifications
- S3:ObjecctCreated, S3:ObjectRemoved, S3:ObjectRestore, S3:Replication...
- Object name filterig possible (*.jpg)
- Use case: geerate thumbnails of images uploaded to S3
- Can create as many "S3 events" as desired
- S3 evet notifications typically deliver evennts i seconnds but ca sometimes take a minute or logger
## S3 Evennt Notifications with Amazon EvenntBridge
- Adanced filterig options with JSON rules (metadata, object size, name...)
- Multiple Destiations - ex Step Fuctios, Kinesis Stream/ Firehose...
- EvenntBrdge CApabilities - Archive, Replay Evet, Reliable delivery
## S3 - Requester Pays
- Ingeeral, bucket owners pay for all Amazon S3 storage ad data trasfer ccosts assocciatted with their bucket
- With Requester Pays buckets, the requester instread of the bucket owner pays the cost of the request and the data download from the bucket
- Helpful when you want to share large datasets with other accoounts
- The requester must be authenticated in AWS (cannot be anonymous)
## Amazon Athena
- Serverless query service to perform analytics against S3 objects
- Uses Stadard SQL language to query files
- Supports CSV, JSON, ORC, Avro, and Parquet (built on Presto)
- Pricinng: $5.00 per TB of data scanned
- Use compressed or ccolumnnar data for cost-savinng (less sccann)
- Use cases: Business intelligece / analytics / reporting, analyze & query VPC Flow Logs, ELB Logs, CloudTrail trails, etc...
- ExamTip: aalyze data in S3 usig serverless SQL, use Athena
## Glaccier Vault Locck
- Adopt a WORM (write Once Read Many) model
- Lock the policy for future edits (can no loger be changed)
- Helpful for compliannce and data retention
## S3 Object Lock (versioning must be enabled)
- Adopt a WORM (Write Onncce Read Many) model
- Block an object version deletion for a specified amount of time
- Object retentio:
    - Retention Period: specifies a fixed period
    - Legal Hold: Same protecctio, no expiry date
- Models:
    - Governance mode: users can't overwrite or delete an object version or alter its lock setting unless they have special permissios
    - Compliance mode: a protected object version ccan't be overwrittenn or deleted by compliance mode, its retention mode ccann't be changed, and its retetion period can't be shortened.
## S3 AWS CloudFront
- Content Delivery etwork (CDN)
- Improves read perfomance, conntennnt is cached atn the edge
- 216 poit of presence globally (edge locations)
- DDOS protection, inntegration witth shield aws web application firewall
- Can expose external HTTPS ad cann talk to internnal HTTPS backends
## CloudFront - Origins
- S3 bucket
    - For distributing files and cachig them at the edge
    - Ennhaced security with CloudFrot Origi Access Identity (OAI)
    - CloudFrot can be used as an igress (to upload files to S3)
- custom Origi (HTTP)
    - Applicatio Load Balancer
    - EC2 instance
    - S3 website (must first enable the buccket as a stati S3 website)
    - Any HTTP backend you want
## CloudFront - S3 as ann Origin
- Allow Public IP of edge locations
- Allow security group of load balancer
- OAI + S3 bucket policy
## CloudFront Geo Restriction
- whitelist and blacklist
## CloudFront vs S3 Cross Region Replication
- Cloudfront
    - Global edge network
    - Files are cacched for TTL (maybe a day)
    - Great for static contet that must be available for everywhere
- S3 Cross Regio Replicatio
    - Must be setup for eacch region you want replication to happen
    - Files are updated i near real-time
    - Readonly
    - Greate for dynamic content that needs to be available at low-latency in few regions
## AWS CloudFront Hands On
- We'll create an S3 bucket
- We'll create a CloudFront distribution
- We'll create an Origi Access Idetity
- We'll limit the S3 bucket to be accessed only using this identity
## CloudFront Siged URL / Signed Cookies
- You want to distribute paid shared cotent to premium users over tthe world
- We can use CloudFront Signed URL/Cookies. We attach a policy with:
    - Include URL expiration
    - Include IP ranges to access the data from
    - Trusted signers (which AWS accounts ccan create signed URLs)
- How long should be URL be valid for?
    - Shared content (movie, music): make it short (a few minnutes)
    - Private content (private to the user): you can make it last for years
- Signed URL = access to individual files (one signed URL per file)
- Signed cookies = access to multiple files (one siged cookie for may files)
## CloudFront Siged URL Diagram
![](https://data.terabox.com/thumbnail/9bd8d2b02q4c1b909d7cd3f1671486b2?fid=4401547290288-250528-880400965818599&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-exScfAfu2mVOs1MJ46CP7OeVlqw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=86318388147826803&dp-callid=0&time=1667055600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudFront Signed URL vs S3 Pre-Signed URL
- CloudFront Signed URL
    - Allow access to a path, no matter the origin
    - Account wide key-pair, only the root can manage it
    - Can filter by IP, path, date, expiratio
    - Can leverage caching features
- S3 Pre- Signed URL
    - Issues a request as the person who pre-signed the URL
    - Uses the IAM key of the signing IAM pricipal
    - Limited lifetime
## CloudFront Pricce class
- Price class: All, 200, 100
![](https://data.terabox.com/thumbnail/1005523ec7d72730e6c714fcb50bc5bd?fid=4401547290288-250528-714242985916769&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-op2aJU07fqBN9TD9TJo1jaw%2bo0k%3d&expires=8h&chkbd=0&chkv=0&dp-logid=87062819966580274&dp-callid=0&time=1667059200&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
# CloudFront Origin
- Based on path pattern:
    - • /images/*
    - • /api/*
    - • /*
- Origin group: high availability and do failover
## CloudFront – Field Level Encryption
- protected user sensitive iformation through application stack, HTTPS, asymmetric encryption
- Adds an additional layer of security along with HTTPS
- Usage:
    - Specify set of fields in POST requests that you want to be encrypted (up to 10 fields) • Specify the public key to encrypt them
## AWS Global Accelerator
- Anycast IP: all servers hold the same IP address and the client is routed to the nearest one
- Unicast IP: one server holds one IP address
- Leverage the AWS internal etwork to route to your applicatio
- 2 anycast IP are created for your application. The anycast IP send traffic directly to edge locations. The Edge locations send traffic to your application
- Performance
    - Intelligent routing to lower latecy any fast regional failover
    - No issue with client cache
    - Interal AWS network
- Health Checcks
    - Global Acccelerator performs a health check
    - Help make your appliccationn global (failover lesstha 1 mintes)
    - Great for disater recovery
- Security
    - Only 2 external IP need to be whhitelisted
    - DDos protectio thanks to AWS shield
## AWS Global Accelerator vs CloudFront
- They both use the AWS global nnetwork and its edge locations around the workld
- Both services inntegrate with AWS Shiled for DDos protectionn
- CloutFront
    - Improves performance for both cache able content (such as images and video)
    - Dynamic content (such as API acceleratio and dynamic site delivery)
    - Content is served at the edge
- Global Accelerator
    - Improves performance for a wide range of application over TCP and UDP
    - Proxying packes at the edge to applications running in one  or more AWS regions
    - Good fit for non-HTTP use cases as gaming  (UDP), IoT (MQTT), or Voice over IP
    - Good for HTTP use cases that require static IP address
    - Good for HTTP use cases that required determistic fast regional failover
## AWS Snow Family
- Highly - secure, portable devices to collect and process data at the edge, and migrate data into and out to AWS
- Data migration: snowcone, snowballedge, snowmobile
- Edge computing: snowcone, snowball edge
## Data migrations with AWS snow Family
- High speeds: 100mbs, 1Gbs, 10Gbs
- Limited connectivity
- Limited bandwidth
- High network cost
- Shared bandwidth
- Connection stability
- offline, more than one week
## Snowball Edge
- Physical data transport solution: move Tbs, Pbs of data in or out AWS
- Pay network fees, pay per data transfer job
- 80TB of HDD capacity for block volume and S3 compatible object storage(storage)
- 42TB of HDD capacity for block volume and S3 compaitible object storage(compute)
- up to 10 nodes
- Use cases: large data cloud migrations, DC deccommisions, disaster recovery
## AWS snowcore
- small, portable computing, anywhere, regged & secure, withstands harsh environments
- Light (4.5 pounds, 2.1 Kg)
- Device used for edge omputing, storage and data transfer
- 8Tbs usable storage
- Use Snowcore when snowball does not fit(space costrained environment)
- Must provide your own battery / cables
- Can be sent back to AWS offline, or connect it to internet and use AWS DataSync to send data
## AWS snowmobile
- Transfer exabytes of data
- Each snowmobile has 100PB of capacity
- High security: temperature control, GPS, 24/7 video surveillance
- Better than snowball if you transfer more than 10 PB
## Usage Process
1. request snowball devices from the AWS console for delivery
2. Install the snowball client / AWS OpsHub on your servers
3. Connect the snowball to your servers and copy files using servers
4. Ship back the device when you're done (goes to the right AWS facility)
5. Data will loaded into an S3 bucket
6. Snowball is completely wiped
## What is Edge computing
- Process data while it's being created, on an edge location
- These locations may have
    - Limited / no internet access
    - Limited / no easy access to computing power
- We setup a Snowball Edge / Snowcone device to do edge computing
- Use case of edge computing
    - Preprocess data
    - Machine learning at the edge
    - Transcoding media streams
- Eventually (if need be) we can ship back the device to AWS (for transfering data)
## Snow family - edge computing
- Snowcone(smaller)
    - 2 CPUs, 4 GB of memory, wired or wireless access • USB-C power using a cord or the optional battery
- Snowball Edge - Compute opimized
    - 52 vCPUs, 208 GiB of RAM. Optional GPU (useful for video processing or machine learning) • 42TBusablestorage
- Snowball Edge - Storage Optimized
    - Up to 40 vCPUs,80 GiB of RAM. Object storage clustering available
- All: can run EC2 instances & AWS Lamba functios (using AWS IoT Greengrass)
- Long-term deployment options: 1 and 3 years discounted pricing
##  AWS OpsHub
- Historical to use Snow family devices, you needed a CLI (Command Line Interface tool)
- Today, you can use AWS OpsHub (a software you install onn your computer latop) to manage your snow family device
    - unlocking and configured single or cluster devices
    - transfering and managig instances runninng on Snow Family devices
    - Launcing and managinng isntannces runnnig on Snow family Devices
    - Monitor devie mmetrics (storage capacity, active isntancces on your device)
    - Launch compatible AWS services on your devices
## Snowball to Glacier
- Snow cannot import to Glacier directly
- You must use Amazone S3 first, in combination with an S3 life cycle policy
## Amazonne FsX - Overview
- Launch 3rd party high-performance file systems on AWS
- Fully managed service
    - FSx for Lustre
    - FSx for windows file server
    - FSx for Netapp ontap
## Amazon Fsx for windows (file server)
- EFS is a shared POSIX system for linux systems.
- FSX for windows is a fully managed widoes file system shared drive
- Supports SMB protocol & windoes NTFS
- Microsoft active directory intefratio ACLS user qoutas
- Can be nmounted o Linux EC2 instances
- Scale up to 10s of GB/s, milios IOPS, 100s PB of data
- Storage options:
    - SSD: latency sensitive workloads (database, media proccessing data analytics, ,,,)
    - HDD: broad spectrum of workloads (home directory, CMS, ...)
- Can be accessed from your o-premises infrastrucure
- Cann be configured to be Multi-AZ
- Data is backed up daily to S3
## Amazon FSx for Lustre (High performance computing)
- Lustre is a type of parallel distributted file system, for large scale computing
- The name Lustre is derived from "linux" and "cluster"
- Machine learning, high performance computing (HPC)
- Video processing, financial modeling, electronic design automation
- Scale up to 100s GB/s, milions of IOPS, sub-ms latencies
- Storage Options:
    - SSD: low-latency, IOPS intensive workloads, small & random file operations
    - HDD: throughput-intensive workloads, large & sequential file operations
- Seamless integration with S3
    - Can "read" S3 as file system (through FSx)
    - Can "write" the output of the computatioos back to S3(through FSx)
- Can be used fron on-premises serves (VPN or Direct Connect)
## FSx File System deployment options
- Scratch File system
    - Temporary storage
    - Data is not replicated (doesn't persit if file server fails)
    - High burst (6x faster, 200MBs per TiB)
    - Usage short-term processing, optimize costs
- Persistent File System
    - Long term storage
    - Data is replicated within same AZ
    - Replace failed files within minutes
    - Usage: long term processing, sensitive data
## Hybrid Cloud for Storage
- AWS is pushing for "hybrid cloud"
    - Part of your infrstruccture is on the cloud
    - Part of your infrastructure is on-premises
- This can be due to
    - Long cloud migrations
    - Security requirements
    - CCCompiliance requirements
    - It Stragegy
- S3 is a proprietary storage technology (uunlike EFS, NFS), so how do you expose the S3 data on premises
- AWS Storage gateway!
## Cloud Storage Cloud Native Options
- Block: EBS, ECS instance store
- File: Amazon EFS, Amazon FsX
- Object: S3, Glacier
## Storage Gateway
- Bridge between on-premise data and cloud data in S3
- Use cases: disater reovery, backup & restore, tiered storage
- 3 types of storage gateway
    - File Gateway
    - Volume Gateway
    - Tape Gateway
## File Gateway
- Configured S3 bucckket are accessible using the NFS and SMB protocol
- Supports S3 standard, S3 IA, S3 One Zoe IA
- Buckket acess using IAM roles for each file Gateway
- Most recently used data is cached in the file Gateway
- Can be mounted on many servers
- Inntegrated with Active Direcctory (AD) for user authentication
![](https://data.terabox.com/thumbnail/9541e54c9b13679479ef98373a5b37b6?fid=4401547290288-250528-565944490476786&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-X99Tte0SKxMpBvSqRo6Un5u%2bgYI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=99464727730881533&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Volume Gateway
- Block storage using iSCSI protocol backed by S3
- Backed by EBS snapshots which can help restore on-premises volumes!
- Cached volumes: low latency acess to most recent data
- Stored volumes: entire dataset is on premise, scheduled backups to S3
![](https://data.terabox.com/thumbnail/3cb88f4372807d6b45b6e250074b5a02?fid=4401547290288-250528-683232502748411&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-4I3kpMtw60JSvW15nB7I%2bxHBVr8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=99515160729716411&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Tape Gateway
- Some companies have backup processes using physical tapes (!)
- With Tape Library (VTL) backed by Amazon S3 and Glacier
- Tape Gateway, compaies use same process but in the cloud
- Backup data using existing tape-based processes (annd iSCSI interface)
- Works witth leading backup software vendors
![](https://data.terabox.com/thumbnail/84727285c82587688cb091a98c54b236?fid=4401547290288-250528-513614965258638&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-cqkt5Msh0Nc%2bXmfv1vUfmEVx5oY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=99607953731024322&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Storage Gateway - Hardware appliance
- Using Storage Gateway means you need on-premises virtualization
- Otherwise, you can use a Storage Gateway Hardware Appliancce
- You can buy it o amazon.com
- Works with File Gateway Colume Gatewaym TapeGateway
- Helpful for daily NFS backups in small data centers
![](https://data.terabox.com/thumbnail/d2e5a24f5a2b943ab07c7123c086aa1b?fid=4401547290288-250528-594951372241647&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-PpQgFjPTYCIqCkQIfUyrGm9TORk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=99867849181510849&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Storage Gateway Summary
- Exam tip: Read the question well, it will hinnt at which gateway to use
- On-premises data to the cloud => Storage Gateway
- File access / NFS - user auth with Active Directory => File Gateway (S3)
- Volume / Block Storage / iSCSI => Volume gateway (backed by EBS snapshots)
- VTL Tape solution / backup with iSCSI => Tape Gateway (backed by S3 and Glacier)
- No on-premises virtualization => Hardware appliance
## Amazon FSx File Gateway
- Native access to Amazon FSx for Windows File Server
- Local cache for frequenncy accessed data
- Windows nnative compatibility (SMB, NTFS, Active Directory...)
- Useful for group file shares and home directories
![](https://data.terabox.com/thumbnail/5accd91da63956a204346a1c85969048?fid=4401547290288-250528-829103490165665&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-jS4ZvFOZ1otQI8K3HPWK77yWHUA%3d&expires=8h&chkbd=0&chkv=0&dp-logid=100080404318942677&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Trannsfer Family
- A fully-mannaged service for file transfer into annd out of amazon S3 or Amazon EFS using the FTP protocol
- Supported Protools
    - AWS Transfer for FTP
    - FTPS
    - SFTP
- Managed infrastucture, Scalable, Reliable, Highly Avaiable (multi AZ)
- Pay per provisioned endpoint per hour + data transfer in GB
- Store and manage user's credentials within the service
- Integrate with existing authenticattion systems (Microsoft  Active Directory, LDAP, Okta, Amazon Cognito, custtom)
- Usage: Sharing files, public datasets, CRM,  ERP, ...
![](https://data.terabox.com/thumbnail/ad8a21eb17b6fd1e04c650a52114cfdf?fid=4401547290288-250528-1051608938615895&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Clj1wJqTI2ud9WRsIF8RYgOyqpw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=100180842465197700&dp-callid=0&time=1667106000&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Storage Comparison
- S3: Object Storage
- Glacier: Object Archival
- EFS: Network file system for linux instances, POSIX filesystem
- FSx for Windows: Netwoork file system for windows servers
- FSx for Lustre: High performance computing linuxx file system
- EBS volumes: Network Storage for one EC2 instance at a time
- Instance Storage: Physiccal storage for your EC2 instance (hhigh IOPS)
- Storage Gateway: File Gateway, Volume Gateway (cache & stored), Tape Gateway
- Snowball/snowmobile: to move large amount of data to theh cloud, physically
- Database: for specific workloads, ussually with indexxing and querying
