---
title: AWS Monitoring, Audit, and Performance
tags:
- aws
- cloud Watch
- SSO
- AWS Resource Access Manager
- SCP
- IAM
- Could Trailt
- EventBridge
categories:
- Fullstack
- Architect
- AWS
---

# AWS Monitoring, Audit and Performance
## AWS CloudWatch Metrics
- Cloudwatch provides metrics for every services in AWS
- Metric is a variable to monitor (CPUUtilization, NetworkIn...)
- Metrics belong to namespaces
- Dimension is an attribute of a metric (instance id, environment, etc...)
- Up to 10 dimensions per metric
- Metrics have timestamps
- Can create CloudWatch dashboards of metrics
## EC2 Detailed monitoring
- EC2 instance metrics have metrics "every 5 minutes"
- With detailed monitoring (for a cost), you get data "every 1 minute"
- Use detailed monitoring if you want to scale faster for you ASG!
- The AWS tier allows us to have 10 detailed monitoring metrics
- Note: EC2 Memory usage is by default not pushed (must be pushed from inside the instance as a custom metric)
## CloudWatch Custom Metrics
- Possibility to define and send your own custom metrics to CloudWatch
- Example: memory (RAM) usage, disk space, number of logged in users ...
- Use API call PutMetricData
- Ability to use dimensions (attributes) to segment metrics
    - Instance.id
    - Environment.name
- Metric resolution (StorageResolution API parameter - two possible value):
    - Standard: 1 minute (60 seconds)
    - High Resolution: 1/5/10/30 second(s) - Highr cost
- Important: Accepts metric data points two weeks in the past and two hours in the future (make sure to configure your EC@ instance time corectly)
## CloudWatch Dashboards
- Great way to setup custom dashboards for quick access to key metrics and alarms
- Dashboards are global
- Dashboards can include graphs from different AWS accounts and regions
- You can change the time zone & time range of dashboards
- You can setup automatic refresh (10s, 1m, 2m, 5m, 15m)
- Dashboards can be shared with people who don't have an AWS account (public, email address, 3rd party SSO provider through Amazon Cognito)
- Pricing
    - 3 dashboards (up to 50metrics) for free
    - $3/dashboard/month afterwards
## CloudWatch Logs
- Log groups: arbitrary name, usually representing an application
- Log stream: instances within application / log files / containers
- Can define log expiration policies (never expire, 30 days, etc..)
- CloudWatch Logs can send logs to:
    - Amazon S3 (exports)
    - Kinesis Data Streams
    - Kinesis Data Firehose
    - AWS Lambda
    - ElasticSearch
## CloudWatch Logs - Sources
- SDK, CloudWatch Logs Agent, CloudWatch Unified Agent
- Elastic Beanstalk: collection of logs from application
- ECS: collection from containers
- AWS Lambda: collection from function logs
- VPC Flow Logs: VPC specific logs
- API Gateway
- CloudTrail based on filter
- Route53: Log DNS queries
## CloudWatch Logs Metric Filter & Insights
- CloudWatch Logs can use filter expressions
    - For example, find a specific IP inside of a log
    - Or count occurrences of "ERROR" in your logs
- Metric filters can be used to triggr CloudWatch alarms
- Cloudwatch Logs Insights can be used to query logs and add queries to CloudWatch Dashboards
## CloudWatch Logs – S3 Export
- Log data can take up to 12 hours to become available for export
- The API call is CreateExportTask
- Not near-real time or real-time... use Logs Subscriptions instead
## CloudWatch Logs Subscriptions
![](https://data.terabox.com/thumbnail/04abc5033f62ea9559263837c91802af?fid=4401547290288-250528-654347901904295&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-onXs40WxMS4HewLr0eNfRXPOyCI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=214382886743684890&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudWatch Logs Aggregation Multi-Account & Multi Region
![](https://data.terabox.com/thumbnail/e8fd758c11e0bf1d1e7e19899638dc31?fid=4401547290288-250528-564143060683598&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-3piASJj%2fo9lfq5mCGzX6e9gghjQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=214454843239863206&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudWatch Logs for EC2
- By default, no logs from your EC2 machine will go to CloudWatch
- You need to run a CloudWatch agent on EC2 to push the log files you want
- Make sure IAM permissions are correct
- The CloudWatch log agent can be setup on premises too
![](https://data.terabox.com/thumbnail/94bbe0b65ca286890f346b574f151f34?fid=4401547290288-250528-696868206928029&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-aS1mqiv8UdNHkdyIrcSC9kGELD4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=214502317154085731&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudWatch Logs Agent & Unified Agent
- For virtual servers (EC2 instances, on-premises servers…)
- CloudWatch Logs Agent
    - Old version of the agent
    - Can only send to CloudWatch Logs
- CloudWatch Unified Agent
    - Collect additional system-level metrics such as RAM, processes, etc…
    - Collect logs to send to CloudWatch Logs
    - Centralized configuration using SSM Parameter Store
## CloudWatch Unified Agent – Metrics
- Collected directly on your Linux server / EC2 instance
- CPU (active, guest, idle, system, user, steal)
- Disk metrics (free, used, total), Disk IO (writes, reads, bytes, iops)
- RAM (free, inactive, used, total, cached)
- Netstat (number of TCP and UDP connections, net packets, bytes)
- Processes (total, dead, bloqued, idle, running, sleep)
- Swap Space (free, used, used %)
- Reminder: out-of-the box metrics for EC2 – disk, CPU, network (high level)
## CloudWatch Alarms
- Alarms are used to trigger notifications for any metric
- Various options (sampling, %, max, min, etc…)
- Alarm States:
    - OK
    - INSUFFICIENT_DATA
    - ALARM
- Period:
    - Length of time in seconds to evaluate the metric
    - High resolution custom metrics: 10 sec, 30 sec or multiples of 60 sec
## CloudWatch Alarm Targets
- Stop, Terminate, Reboot, or Recover an EC2 Instance
- Trigger Auto Scaling Action
- Send notification to SNS (from which you can do pretty much anything)
![](https://data.terabox.com/thumbnail/ddbaea3f8ded408a8f0653c3d65c0a71?fid=4401547290288-250528-797778510712352&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-98bL1hXiVpkLZUcaHUSmZ0PhaCk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=214613010955798462&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## EC2 Instance Recovery
- Status Check:
    - Instance status = check the EC2 VM
    - System status = check the underlying hardware
- Recovery: Same Private, Public, Elastic IP, metadata, placement group
![](https://data.terabox.com/thumbnail/e2f4b6e0be6f860bba4ae42014d37403?fid=4401547290288-250528-247094783744706&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-qqAWhdFvYxfoxtPL%2fawDafGEceM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=214633180891749929&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudWatch Events
- Event pattern: Interceot events from AWS services (Sources)
    - Example sources: EC2 instance start, CodeBuild Failre, S3, Trusted Advisor
    - Can intercept any API call with CloudTrai integration
- Schedule or Cron (example: create an event every 4 hours)
- A JSON payload is created from the event and passed to a target...
    - Compute: Lambda, Batch, ECS task
    - Integration: SQS, SNS, Kinesis Data Streams, Kinesis Data Firehose
    - Orchestration: Step functions, CodePipeline, CodeBuild
    - Maintenance: SSM, EC2 Actions
## Amazon EventBridge
- EventBridge is the next evolution of CloudWatch Events
- Default Event Bus - generated by AWS services (CloudWatch Events)
- Partner Event Bus: receive events from SaaS service or applications (Zendesk, DataDog, Segment, Auth0…)
- Custom Event Buses: for your own applications
- Event Buses can be accessed by other AWS accounts
- You can archive events (all/filter) sent to an event bus (indefinitely or set period)
- Ability to replay archived events
- Rules: how to process the events (like couldwatch events)
## Amazon EvntBridge - Schema Registry
- EventBridge can analyze the events in your bus and infer the schema
- The Schema Registry allows you to generate code for your application, that will know in advance how data is structured in the event bus
- Schema can be versioned
## Amazon EventBridge – Resource-based Policy
- Manage permissions for a specific Event Bus
- Example: allow/deny events from another AWS account or AWS region
- Use case: aggregate all events from your AWS Organization in a single AWS account or AWS region
![](https://data.terabox.com/thumbnail/1062a56fc93b25be661215f52fb713c6?fid=4401547290288-250528-732538512753138&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-jMuvWqMrK%2f9ZdDpnpE8OFOQzuGI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=215098522923733259&dp-callid=0&time=1667534400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon EventBridge vs CloudWatch Events
- Amazon EventBridge builds upon and extends CloudWatch Events.
- It uses the same service API and endpoint, and the same undrlying service infrastructure
- EventBridge allows extension to add event buses for your custom applications and your third-party SaaS apps.
- Event Bridge has the Schema registry capability
- EventBridge has a different name to mark the new capabilities
- Over time, the CloudWatch Events name will be replaced with EventBridge
## AWS CloudTrail
- Provides governance, compliance and audit for your AWS Account
- CloudTrail is enabled by default!
- Get an history of events / API calls made within your AWS Account by:
    - Console
    - SDK
    - CLI
    - AWS Services
- Can put logs from CloudTrail into Cloud
- A trail can be applied to All Regions (default) or a single Region
- If a resource is deleted in AWS, investigate CloudTrail first!
## CloudTrail Diagram
![](https://data.terabox.com/thumbnail/02bbac5944dd32497977380a03adc90a?fid=4401547290288-250528-214387842489131&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-xgqy9yQh980wuzWUNLu%2brYoNwFs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=216773946963548255&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudTrail Events
- Management Events:
    - Operations that are performed on resources in your AWS account
    - Examples:
        - Configuring security (IAM AttachRolePolicy)
        - Configuring rules for routing data (Amazon EC2 CreateSubnet)
        - Setting up logging (AWS CloudTrail CreateTrail)
    - By default, trails are configured to log management events.
    - Can separate Read Events (that don’t modify resources) from Write Events (that may modify resources)
- Data Events:
    - By default, data events are not logged (because high volume operations)
    - Amazon S3 object-level activity (ex: GetObject, DeleteObject, PutObject ): can separate Read and Write Events
    - AWS Lambda function execution activity (the Invoke API)
- CloudTrail Insights Events
    - See next slide
## CloudTrail Insights
- Enable CloudTrail Insights to detect unusual activity in your account:
    - inaccurate resource provisioning
    - hitting service limits
    - Bursts of AWS IAM actions
    - Gaps in periodic maintenance activity
- CloudTrail Insights analyzes normal management events to create a baseline
- And then continuously analyzes write events to detect unusual patterns
    - Anomalies appear in the CloudTrail console
    - Event is sent to Amazon S3
    - An EventBridge event is generated (for automation needs)
![](https://data.terabox.com/thumbnail/d03d0805fe9fb0bc9c6875db29411916?fid=4401547290288-250528-921135651322767&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-aC53BeSg0dRKxConuj%2bWytxh1%2b4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=216881216511701042&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudTrail Events Retention
- Events are stored for 90 days in CloudTrail
- To keep events beyond this period, log them to S3 and use Athena
![](https://data.terabox.com/thumbnail/57a5f83744cba9eda0a2b025deb798e0?fid=4401547290288-250528-975671270385073&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-OeWjkd5je8R2SHJ3yp3V0Di%2b6xo%3d&expires=8h&chkbd=0&chkv=0&dp-logid=216898217029829320&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Config
- Helps with auditing and recording compliance of your AWS resources
- Helps record configurations and changes over time
- Questions that can be solved by AWS Config:
    - Is there unrestricted SSH access to my security groups?
    - Do my buckets have any public access?
    - How has my ALB configuration changed over time?
- You can receive alerts (SNS notifications) for any changes
- AWS Config is a per-region service
- Can be aggregated across regions and accounts
- Possibility of storing the configuration data into S3 (analyzed by Athena)
## Config Rules
- Can use AWS managed config rules (over 75)
- Can make custom config rules (must be defined in AWS Lambda)
    - Ex: evaluate if each EBS disk is of type gp2
    - Ex: evaluate if each EC2 instance is t2.micro
- Rules can be evaluated / triggered:
    - For each config change
    - And / or: at regular time intervals
- AWS Config Rules does not prevent actions from happening (no deny)
- Pricing: no free tier, $0.003 per configuration item recorded per region,
$0.001 per config rule evaluation per region
## AWS Config Resource
- View compliance of a resource over time
- View configuration of a resource over time
- View CloudTrail API calls of a resource over time
![](https://data.terabox.com/thumbnail/0b03aa61f9308e33d2a4f29ed032b8e8?fid=4401547290288-250528-126345804289668&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-9tlYGB3a2lXlNx6tpxGU33Gyfzk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=216970130579784745&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Config Rules – Remediations
- Automate remediation of non-compliant resources using SSM Automation
Documents
- Use AWS-Managed Automation Documents or create custom Automation
Documents
    - Tip: you can create custom Automation Documents that invokes Lambda function
- You can set Remediation Retries if the resource is still non-compliant after auto-remediation
## Config Rules – Notifications
- Use EventBridge to trigger notifications when AWS resources are non-compliant
![](https://data.terabox.com/thumbnail/a8cc45b5f21a7b84a2572d25bb429135?fid=4401547290288-250528-103163448512458&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-xK%2bhzEo83usxGVgyMZ90qzk1Yc0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=217017174480331262&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Ability to send configuration changes and compliance state notifications
to SNS (all events – use SNS Filtering or filter at client-side)
![](https://data.terabox.com/thumbnail/62129b58c7d62f89ce9a2babea056a9b?fid=4401547290288-250528-559254806949063&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-nBO5AgojcgZ2CnjrswOMU39KuJw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=217030677069452616&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## CloudWatch vs CloudTrail vs Config
- CloudWatch
    - Performance monitoring (metrics, CPU, network, etc…) & dashboards
    - Events & Alerting
    - Log Aggregation & Analysis
- CloudTrail
    - Record API calls made within your Account by everyone
    - Can define trails for specific resources
    - Global Service
- Config
    - Record configuration changes
    - Evaluate resources against compliance rules
    - Get timeline of changes and compliance
## For an Elastic Load Balancer
- CloudWatch:
    - Monitoring Incoming connections metric
    - Visualize error codes as % over time
    - Make a dashboard to get an idea of your load balancer performance
- Config:
    - Track security group rules for the Load Balancer
    - Track configuration changes for the Load Balancer
    - Ensure an SSL certificate is always assigned to the Load Balancer (compliance)
- CloudTrail:
    - Track who made any changes to the Load Balancer with API calls
## AWS STS – Security Token Service
- Allows to grant limited and temporary access to AWS resources.
- Token is valid for up to one hour (must be refreshed)
- AssumeRole
    - Within your own account: for enhanced security
    - Cross Account Access: assume role in target account to perform actions there
- AssumeRoleWithSAML
    - return credentials for users logged with SAML
- AssumeRoleWithWebIdentity
    - return creds for users logged with an IdP (Facebook Login, Google Login, OIDC compatible…)
    - AWS recommends against using this, and using Cognito instead
- GetSessionToken
    - for MFA, from a user or AWS account root user
## Using STS to Assume a Role
- Define an IAM Role within your account or cross-account
- Define which principals can access this IAM Role
- Use AWS STS (Security Token Service) to retrieve credentials and impersonate the IAM Role you have access to (AssumeRole API)
- Temporary credentials can be valid between 15 minutes to 1 hour
![](https://data.terabox.com/thumbnail/f1d2c1be6986a81036eac50b1bcc816d?fid=4401547290288-250528-586507772444246&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-dQeHKjTxRALscaP17oqmSwEGKB8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=217154853426255026&dp-callid=0&time=1667541600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Cross account access with STS
![](https://data.terabox.com/thumbnail/dd93815065652baf5575c1edf5d2b9ff?fid=4401547290288-250528-106028331143318&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-c5%2bFMH%2bj6jKHB3fUlFbfzxrUSiI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=217170673819591883&dp-callid=0&time=1667545200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Identity Federation in AWS
- Federation lets users outside of AWS to assume temporary role for accessing AWS resources.
- These users assume identity provided access role.
- Federations can have many flavors:
    - SAML 2.0
    - Custom Identity Broker
    - Web Identity Federation with Amazon Cognito
    - Web Identity Federation without Amazon Cognito
    - Single Sign On
    - Non-SAML with AWS Microsoft AD
- Using federation, you don’t need to create IAM users (user management is outside of AWS)
![](https://data.terabox.com/thumbnail/b7b593e9b55d8eb96e9bc621ccb6658e?fid=4401547290288-250528-334549767703471&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-PLQKzuPbp1gY%2fht9WBM2zq5gd6U%3d&expires=8h&chkbd=0&chkv=0&dp-logid=217204789707972375&dp-callid=0&time=1667545200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SAML 2.0 Federation
- To integrate Active Directory / ADFS with AWS (or any SAML 2.0)
- Provides access to AWS Console or CLI (through temporary creds)
- No need to create an IAM user for each of your employees
![](https://data.terabox.com/thumbnail/c7b6d0d32fb9325fa79378ae2db95960?fid=4401547290288-250528-392525858093714&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-N7xJnVPKomz6%2bzW4X3V59PFjECQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=218333761575233277&dp-callid=0&time=1667548800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SAML 2.0 Federation – Active Directory FS
- Same process as with any SAML 2.0 compatible IdP
![](https://data.terabox.com/thumbnail/8d166b5f5668aaaaf8afb53e2a1f7ac0?fid=4401547290288-250528-886776048673321&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-OE2vKD3%2fQ88rJyhXCWF0zxrtBOc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=218375574990367700&dp-callid=0&time=1667548800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SAML 2.0 Federation
- Needs to setup a trust between AWS IAM and SAML (both ways)
- SAML 2.0 enables web-based, cross domain SSO
- Uses the STS API: AssumeRoleWithSAML
- Note federation through SAML is the “old way” of doing things
- Amazon Single Sign On (SSO) Federation is the new managed and
simpler way
    - Read more here: https://aws.amazon.com/blogs/security/enabling-federation-to-aws-using-windows-active-directory-adfs-and-saml-2-0/
## Custom Identity Broker Application
- Use only if identity provider is not compatible with SAML 2.0
- The identity broker must determine the appropriate IAM policy
- Uses the STS API: AssumeRole or GetFederationToken
![](https://data.terabox.com/thumbnail/c84c5765074b7152eaaf54c23a13230e?fid=4401547290288-250528-529214597819384&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-rzChLMVt0SwfeP2szURmVug0YF0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=218515452911764723&dp-callid=0&time=1667548800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Web Identity Federation – AssumeRoleWithWebIdentity
- Not recommended by AWS – use Cognito instead (allows for anonymous users, data synchronization, MFA)
![](https://data.terabox.com/thumbnail/b422116600cfe161f80bddce9e993c50?fid=4401547290288-250528-291953383498164&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Ffo0tucrBoAmDnukDQ%2bz7YTSy%2bE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=218568517770816282&dp-callid=0&time=1667548800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Cognito
- Goal:
    - Provide direct access to AWS Resources from the Client Side (mobile, web app)
- Example:
    - provide (temporary) access to write to S3 bucket using Facebook Login
- Problem:
    - We don’t want to create IAM users for our app users
- How:
    - Log in to federated identity provider – or remain anonymous
    - Get temporary AWS credentials back from the Federated Identity Pool
    - These credentials come with a pre-defined IAM policy stating their permissions
## What is Microsoft Active Directory (AD)?
- Found on any Windows Server with AD Domain Services
- Database of objects: User Accounts, Computers, Printers, File Shares, Security Groups
- Centralized security management, create account, assign permissions
- Objects are organized in trees
- A group of trees is a forest
## AWS Directory Services
- AWS Managed Microsoft AD
    - Create your own AD in AWS, manage users locally, supports MFA
    - Establish “trust” connections with your on-premises AD
- AD Connector
    - Directory Gateway (proxy) to redirect to on-premises AD, supports MFA
    - Users are managed on the on-premises AD
- Simple AD
    - AD-compatible managed directory on AWS
    - Cannot be joined with on-premises AD
## AWS Organizations
- Global service
- Allows to manage multiple AWS accounts
- The main account is the master account – you can’t change it
- Other accounts are member accounts
- Member accounts can only be part of one organiztion
- Consolidated Billing across all accounts - single payment method
- Pricing benefits from aggregated usage (volume discount for EC2, S3...)
- API is available to automate AWS account creation
## Multi Account Strategies
- Create accounts per department, per cost center, per dev / test / prod, based on regulatory restrictions (using SCP), for better resource isolation (ex: VPC), to have separate per-account service limit, isolated account for logging
- Multi Account vs One Account Multi VPC
- Use tagging standards for billing purposes
- Enable CloudTrail on all accounts, send logs to central S3 account
- Send CloudWatch logs to central logging account
- Establish cross account roles for admin purposes
## Organizational Units (OU) - Examples
![](https://data.terabox.com/thumbnail/35165b599028b6e66b8ff3c68261e234?fid=4401547290288-250528-100081827684100&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Js5vxsrebBtVLAyN1KJuw9elCNw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=219979697638906354&dp-callid=0&time=1667552400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Organization
![](https://data.terabox.com/thumbnail/0d68a0e813e6cbf2d725939349d08c5f?fid=4401547290288-250528-167070688745664&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-eyL115l79CGrrkXSambKyQM6iyo%3d&expires=8h&chkbd=0&chkv=0&dp-logid=219991520664672598&dp-callid=0&time=1667552400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Service Control Policies (SCP)
- Whitelist or blacklist IAM actions
- Applied at the OU or Account level
- Does not apply to the Master Account
- SCP is applied to all the Users and Roles of the Account, including Root user
- The SCP does not affect service-linked roles
    - Service-linked roles enable other AWS services to integrate with AWS Organizations and can't be restricted by SCPs.
- SCP must have an explicit Allow (does not allow anything by default)
- Use cases:
    - Restrict access to certain services (for example: can’t use EMR)
    - Enforce PCI compliance by explicitly disabling services
## SCP Hierarchy
![](https://data.terabox.com/thumbnail/2285cc827173fd732d8454786920cc49?fid=4401547290288-250528-35219311130830&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-1OE9aXOfPDhIAxYgMKQgnmgH8Cc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220027427804734668&dp-callid=0&time=1667552400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/48227a166faffa2f5c5f45c81bd7467f?fid=4401547290288-250528-432741673575103&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-pAm%2bVCEHq5be4n1u9sP0KMfz%2f6M%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220050632987484899&dp-callid=0&time=1667552400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Organization – Moving Accounts
- To migrate accounts from one organization to another
    1. Remove the member account from the old organization
    2. Send an invite to the new organiztion
    3. Accept the invite to the new organization from the member account
- If you want the master account of the old organization to also join the new organization, do the following:
    1. Remove the member accounts from the organizations using procedure above
    2. Delete the old organization
    3. Repeat the process above to invite the old master account to the new org
![](https://data.terabox.com/thumbnail/154626f7672f7594c5d62c0131cf55be?fid=4401547290288-250528-983569818853867&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-bClV8%2fOV0ZZkv9zPkrgyrnQBttY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220109457588015889&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## IAM Conditions
![](https://data.terabox.com/thumbnail/594cb3e1dc8410385d534845e0d73ca0?fid=4401547290288-250528-611246829116890&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-bMgtu1lDQq4KL2K4wvDaaJ%2bHg9U%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220124888680246170&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/9316e2704af9e607c6581b35775bf39d?fid=4401547290288-250528-481221424643039&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-uj17NK53LhttIQCy4LdYSmaVvog%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220148473480242532&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## IAM for S3
- ListBucket permission applies to arn:aws:s3:::test
- => bucket level permission
- GetObject, PutObject, DeleteObject applies to arn:awn:s3:::test/*
- => object level permission
![](https://data.terabox.com/thumbnail/9316e2704af9e607c6581b35775bf39d?fid=4401547290288-250528-318631966680319&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-pPIbv91WNwmdpjXtkvtyTA2HRnk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220150227236216663&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## IAM Roles vs Resource Based Policies
- Attach a policy to a resource (example: S3 bucket policy) versus attaching of a using a role as a proxy
![](https://data.terabox.com/thumbnail/d6407a4bade989333c0c629856786ecb?fid=4401547290288-250528-286178952248615&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-K7KCAsw1asrNk7ejANhyVv8fBik%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220195210904642544&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## IAM Roles vs Resource Based Policies
- When you assume a role (user, application or service), you give up your
original permissions and take the permissions assigned to the role
- When using a resource based policy, the principal doesn’t have to give
up his permissions
- Example: User in account A needs to scan a DynamoDB table in Account A and dump it in an S3 bucket in Account B
- Supported by: Amazon S3 buckets, SNS topics, SQS queues, etc…
## IAM Permission Boundaries
- IAM Permission Boundaries are supported for users and roles (not groups)
- Advanced feature to use a managed policy to set the maximum permissions
an IAM entity can get.
![](https://data.terabox.com/thumbnail/790035040f5cd2bdf957df2feedf0f03?fid=4401547290288-250528-417917140952444&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-m7HDIuD1g1xNxmySEv%2fBENobQ8A%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220242801437375018&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## IAM Permission Boundaries
- Can be used in combinations of AWS Organizations SCP
![](https://data.terabox.com/thumbnail/a911c7832b93e96f4702d05a584c65dc?fid=4401547290288-250528-992783932441151&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-UHskvAwCs2aD5LAyT%2bx0tdun8E8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220260884841035928&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Use cases
    - Delegate responsibilities to non administrators within their permission
    - Allow developers to self-assign policies and manage their own permissions, while making sure they can't escalate their privileges (= make themselves admin)
    - Useful to restrict one specific user (instead of a whole account using Organizations & SCP)
## IAM Policy Evaluation Logic
![](https://data.terabox.com/thumbnail/afe0378f0df5690b80975a28c7ae4af8?fid=4401547290288-250528-801969616342204&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-RF04bAkcQ9z%2f9XG9aZMfGKJW4ic%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220365060183320422&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Example IAM Policy
- Can you perform sqs:CreateQueue?
- Can you perform sqs:DeleteQueue?
- Can you perform ec2:DescribeInstances?
## AWS Resource Access Manager (RAM)
- Share AWS resources that you own with other AWS accounts
- Share with any account or within your Organization
- Avoid resource duplication!
- VPC Subnets:
    - allow to have all the resources launched in the same subnets
    - must be from the same AWS Organizations.
    - Cannot share security groups and default VPC
    - Participants can manage their own resources in there
    - Participants can't view, modify, delete resources that belong to other participants or the owner
- AWS Transit Gateway
- Route53 Resolver Rules
- License Manager Configurations
## Resource Access Manager – VPC example
![](https://data.terabox.com/thumbnail/d42dc3700f48b3c0ed035a53dbb3eea4?fid=4401547290288-250528-1097540045173168&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-HHVgvb4r7b3a2hAaZ93qUkpzplc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220415791121398441&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Each account…
    - is responsible for its own resources
    - cannot view, modify or delete other resources in other accounts
- Network is shared so…
    - Anything deployed in the VPC can talk to other resources in  the VPC
    - Applications are accessed easily across accounts, using private IP!
    - Security groups from other accounts can be referenced for maximum security
## AWS Single Sign-On (SSO)
- Centrally manage Single Sign-On to access multiple accounts and 3rd -party business applications.
- Integrated with AWS Organizations
- Supports SAML 2.0 markup
- Integration with on-premises Active Directory
- Centralized permission management
- Centralized a auditing with CloudTrail
![](https://data.terabox.com/thumbnail/51d7fae9d4fc55bcbfec6e74926e0666?fid=4401547290288-250528-678752735626691&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-3OX3fEJJzW6aaJ1%2fnTg0E2u%2bVUs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220471516869484801&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Single Sign-On (SSO) – Setup with AD
![](https://data.terabox.com/thumbnail/80a455cfed4ab80ff3825dc97a13f051?fid=4401547290288-250528-476059878497071&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-ELAR6fn%2fjySBywKunKtB6sGaJX8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220490648943574061&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SSO – vs AssumeRoleWithSAML
![](https://data.terabox.com/thumbnail/22ceba706f9b6b5542266f20edd2a3d7?fid=4401547290288-250528-688792890826970&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-0N45qASqeo41kR4D3ocicPGOfhE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=220508371845466250&dp-callid=0&time=1667556000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
