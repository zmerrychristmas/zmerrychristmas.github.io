---
title: 'AWS Advance: ElastiCache, RDS and Aurora part 1'
categories:
- Fullstack
- AWS
- Architect
tags:
- |-
  aws
  aurora
- elasticcache
- rds
- aurora
- redis
- memcache
- template
- asg
- acl
- NLB
---

# SSL/TLS - Basics
- An **SSL Certificate** allow traffic between your clients and your load balancer to be encrypted in transit (i-flight encryption)
- **SSL** refers to Secure Soccket Layeer, used to encrypt conections
- **TLS** refers to transport layer security, which is a newer versio
- Nowadays, TLS certificates are mainly used, but people still refer as SSL
- Public SSL certificates are issued by Certificate Authorities (CA)
- Comodo, Symantec, GoDaddy, GlobalSign, Digicert, Letsencrypt,  etc...
- SSL ccertificates have an expiration date (yout set) and must be renewed
## Load Balacer - SSL Certificates
- The load balacer uses and** X.509 certificate** (SSL/TLS server certificcate)
- You can manage certificcates using ACM (AWS Certificate Manager)
- You can create upload your own certificates alternatively
- HTTPS listener
    - You must specify a default certificate
    - You can add an optional list of certs to support multiple domains
    - Clients can use **SNI** (Server Name Indication) to specify the host name they reach
    - Ability to specify a security policy to support older versions of SSL / TLS (legacy clients)
## SSL - Server Name idication (SNI)
- SNI sloves the problem of loadinng multiple **SSL certificates** onto one web server (to serve multiple websites)
-It's a 'newer' protocol, and requires the client to indicate the hostname of the target server in the initial SSL hanshake
- The server will then find the correct certificccate, or return the default one
- Note:
    - Only work for ALB & CLB (newer generation), Cloudfront
    - Does not work for CLB ( older gen)
## Elastic Load Balancers - SSL Certicates
- Classic Load Balancer (v1)
    - Support only one **SSL certificate**
    - Must use multiple CLB for *multiple host name with multiple SSL certificates*
- Application Load Balanccer (v2)
    - Supports **multiple listeners with multiple SSL certificcates** 
    - Uses serve name indication (SNI) to make it work
- Network Load Balancer (v2)
    - **Supports multiple listeners with multiple SSL certificates**
    - Uses Server Name Indication (SNI) to make it work
## Connection Draining
- Feature naming
    - **Connection Draining** - for CLB
    - **Deregistration Delay** - for ALB & NLB
- Time to complete "i-fight request" while the instance is de-registerinng or unhealthy
- Stops sending ew request to EC2 instance which is de-registering
- Between 1 to 3600 seconds ( default 300 seconds)
- Can be disabled (set value to 0)
- Set to a low value if your request are short
## What's an Auto Scaling Group?
- In real-life, the load on your websites and application can change
- In the cloud, you can create and get rid of servers very quickly 
- The goal of an **Auto Scalinng Group** (ASG) is to:
    - Scale out (add EC2 instances) to match an increased load
    - Scale in (remove EC2 instances) to match a decreased load
    - Ensure we have a minimum and a maximum number of machinnes running
    - Automatically Register new instances to a load balancer
## Auto Sccaling Group in AWS With Load Balancer
- A launch configuration
    - AMI + Instance Type
    - EC2 User data
    - EBS Volumes
    - Security Groups
    - SSH key pair
- Min size / Max size / Initial capacity
- Network + Subnets informatio
- Load balancer information
- Scaling Policies
## Auto Scaling Alarms
- It is possible to scale an ASG based on* CloudWatch alarms*
- An Alarm monitors a metric (such as Average CPU)
- Metrics are computed for the overall ASG instances
- Based on the alarm
    - We can create scale-out policies (increase the number of instances)
    - We can create scale-in policcies (decrease the number of instances)
## Auto scaling new rules
- It is now possible to define "better" auto scaling rules that are directly managed by EC2
    - Target Average CPU Usage
    - Number of request on ELB per instance
    - Average Network In
    - Average Network Out
- These rules are are easier to setup and can make more sense
## Auto Scaling Custom Metric
- We can auto scale *based on a custom metric* ( number of connect users)
1. Send custom metric from application on EC2 to **CloudWatch** (PutMetric API)
2. Create CloudWatch alarm to react to low / high values
3. Use the CloudWatch alarm as the scaling policy for ASG
## ASG Brain Dump
- Scaling policies can be on *CPU, Network... and can even be on custom metrics* or based on a schedule (if you know your visitor patterns)
- ASGs use Launch configurations or Launch configuration / launch template
- **IAM** roles attached to an ASG will get assigned to EC2 instances
- ASG are free. You pay for the underlying resources being launched 
- Having instances under an ASG means that if they get terminated for whatever reason, the ASG will automatically create new onces as a replacement. Extra safety!
- ASG can terminate instances marked as unhealthy by an ALB(and hence replace them)
## Auto Sccaling Groups - Dynamic Scaling Policies
- Target Trackkinng Scaling
    - Most simple and easy to set up
    - Example: I want the average ASG CPU to stay at around 40%
- Simple / Step Scaling
    - When a CloudWatch alarm is triggerd(>70%), then add 2 units
    - When a CloudWatch alarm is triggerd(<30%), then remove 1
- Sechedule Actions
    - Anticipate a sccaling based on known usage **patterns**
    - Example: increase the min capacity to 10 at 5 pm on Fridays
## Auto Scaling Groups - Predictive scaling
- **Predictive scaling**: continously forecast load and schedule scaling ahead
    - analysis historical, generate forecast, schedule
## Good metrics to scale on 
- **CPUUtillizatioon**: Average CPU
utilization across your instances
- **RequestCountPerTarget**: to make sure the number of requests per EC2 instances is stable
- **Average Network  In/Out** (if you're application is network bound)
- Any custom metric (that you push using CloudWatch)
## Auto Scaling Groups - Scaling cooldowns
- After a scaling activity happes, you are in the cooldown period (300second)
- During the cooldown period, the ASG will not launch or teminate additional instance (to allow for metrics to stabilize)
- Advice: Use a ready to use **AMI** to reduce configuration time in order to be serving request faster and reduce the cooldown period
## ASG for Solutions Architects
- ASG Default termination policy(simplified version)
    - **Find** the AZ which has the most number of instaces 
    - If there are multiple instances in the AZ to choose from, delete the one with **the oldest launch configuration**
- ASG tries the balance the number of instances across AZ by default
## ASG for solutions architects lifecycle hooks
-  By default as soon as an istance is launched in an ASG it's in service
- You have the** ability to perform **extra steps before the instance goes i service(Pendinng state)
- You have the** ability to perform some actions** before the innstannce is terminated
## ASG for solutions architect launch template vs launch configuration
- Both:
    - ID of the Amazon machie Image (AMI), the instance type, a key security groups, and the other parameter that you use to launch EC2 istances(tags, EC2 user-data)
- **Launch Configuration** (Legacy):
    - Must be re-created every time
- **Launch Template** (newer)
    - Can have multiple versions
    - Create parameters subsets (partial cconfiguration for re-use annd inheritance)
    - **PRovision using both On-Demand and Spot instances** 
    - Can use T2 unlimited brust features
    - Recomend by AWS going forward
