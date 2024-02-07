---
title: 'AWS Container: Docker, ECS and EKS'
tags:
- aws
- ECS
- EKS
- Docker
categories:
- Fullstack
- Architect
- Blogging
---

# Container Section
- Docker is a software development platform to deploy apps
- Apps are packaged in containers that can be run on any OS
- Apps run the same, regardless of where they're run
    - Any machine
    - No compatibility issues
    - Predictable behavior
    - Less work
    - Easier to maintain and deploy
    - Works with any language, any OS, any technology
- Use cases: microservices architecture, lift and shift apps from on-premises to the AWS cloud,...
## Where are Docker images stored?
- Docker images are stored in Docker Repositories
- Docker Hub (https://hub.docker.com)
    - public repossitory
    - Find base images for many technologies or OS (e.g., Ubuntu, MySQL, …
- Amazon ECR (Amazon Elastic Container Registry)
    - Private repository
    - Public repository (Amazon ECR Public Gallery https://gallery.ecr.aws)
## Docker vs. Virtual Machines
- Docker is ”sort of ” a virtualization technology, but not exactly
- Resources are shared with the host => many containers on one server
## Getting Started with Docker
![](https://data.terabox.com/thumbnail/7a21be30ab3740c9b0ccbff834a605d8?fid=4401547290288-250528-696220612022660&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-pGZrj0D%2fcsGp5lXnqu%2fPRfBvoUA%3d&expires=8h&chkbd=0&chkv=0&dp-logid=168129589003422510&dp-callid=0&time=1667361600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Docker Containers Management on AWS
- Amazon Elastic Container Service (Amazon ECS)
    - Amazon’s own container platform
- Amazon Elastic Kubernetes Service (Amazon EKS)
    - Amazon’s managed Kubernetes (open source)
- AWS Fargate
    - Amazon’s own Serverless container platform
    - Works with ECS and with EKS
- Amazon ECR
    - Store container images
## Amazon ECS - EC2 Launch Type
- ECS = Elastic Container Service
- Launch Docker containers on AWS = Launch ECS Tasks on ECS Clusters
- EC2 Launch Type: you must provision & maintain the infrastructure (the EC2 instances)
- Each Ec2 Instance must run the ECS agent to register in the ECS Cluster
- AWS takes care of starting / stoping containers
![](https://data.terabox.com/thumbnail/5ba5b2a7f4210788d2b82a35bb47cd9f?fid=4401547290288-250528-1047822937550125&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-AsjIDKuPcKpwt%2bDJBoE860aNW20%3d&expires=8h&chkbd=0&chkv=0&dp-logid=168407832683007370&dp-callid=0&time=1667361600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon ECS – Fargate Launch Type
- Launch Docker containers on AWS
- You do not provision the infrastructure (no EC2 instances to manage)
- It’s all Serverless!
- You just create task definitions
- AWS just runs ECS Tasks for you based on the CPU / RAM you need
- To scale, just increase the number of tasks. Simple - no more EC2 instances
![](https://data.terabox.com/thumbnail/060ce65eaf587e16eaa807ed2501923e?fid=4401547290288-250528-157612270958542&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-xOiN4%2bA2UId%2focrcnt5RNUc%2bwq8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=168445657231502169&dp-callid=0&time=1667361600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon ECS – IAM Roles for ECS
- EC2 Instance Profile (EC2 Launch Type only):
    - Used by the ECS agent
    - Makes API calls to ECS service
    - Send container logs to CloudWatch Logs
    - Pull Dockerimage from ECR
    - Rederence sensitive data in secrets manager or SSM Parameter Store
- ECS Task Role
    - Allows each task to have a specific role
    - Use different roles for the different ECS Services you run
    - Task Role is defined in the task definition
![](https://data.terabox.com/thumbnail/cc1a175f97040a1f5db0aa664f785acd?fid=4401547290288-250528-540628310980848&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EbFBclzbxUbD1MGncUAGjPVZmpU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=170430105137418816&dp-callid=0&time=1667368800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon ECS – Load Balancer Integrations
- Application Load Balancer supported and works for most use cases
- Network Load Balancer recommended only for high throughput / high performance use cases, or to pair it with AWS Private Link
![](https://data.terabox.com/thumbnail/70698a78495511fde83a50d5d8206da2?fid=4401547290288-250528-1073416534126133&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-VkdkOlUE9UL9B38TsbBviNz3QTM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=170484519495461593&dp-callid=0&time=1667368800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Elastic Load Balancer supported but not recommended (no advanced features – no Fargate)
## Amazon ECS – Data Volumes (EFS)
- Mount EFS file systems onto ECS tasks
- Works for both EC2 and Fargate launch types
- Tasks running in any AZ will share the same data
in the EFS file system
- Fargate + EFS = Serverless
- Use cases: persistent multi-AZ shared storage for your containers
- Note:
    - FSx For Lustre is not supported
    - Amazon S3 cannot be mounted as a file system
## ECS Service Auto Scaling
- Automatically increase/decrease the desired number of ECS tasks
- Amazon ECS Auto Scaling uses AWS Application Auto Scaling
    - ECS Service Average CPU Utilization
    - ECS Service Average Memory Utilization - Scale on RAM
    - ALB Request Count Per Target – metric coming from the ALB
- Target Tracking – scale based on target value for a specific CloudWatch metric
- Step Scaling – scale based on a specified CloudWatch Alarm
- Scheduled Scaling – scale based on a specified date/time (predictable changes)
- ECS Service Auto Scaling (task level) ≠ EC2 Auto Scaling (EC2 instance level)
- Fargate Auto Scaling is much easier to setup (because Serverless)
## EC2 Launch Type – Auto Scaling EC2 Instances
- Accommodate ECS Service Scaling by adding underlying EC2 Instances
- Auto Scaling Group Scaling
    - Scale your ASG based on CPU Utilization
    - Add EC2 instances over time
- ECS Cluster Capacity Provider
    - Used to automatically provision and scale the infrastructure for your ECS Tasks
    - Capacity Provider paired with an Auto Scaling Group
    - Add EC2 Instances when you’re missing capacity (CPU, RAM…)
## ECS Scaling – Service CPU Usage Example
![](https://data.terabox.com/thumbnail/b25a2ab9d8200f9458966daae1a5ee9d?fid=4401547290288-250528-842050794538089&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-%2bN9IcS4s97uMuvIXFYxXbwFO5ng%3d&expires=8h&chkbd=0&chkv=0&dp-logid=170732452863976122&dp-callid=0&time=1667368800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## ECS Rolling Updates
- When updating from v1 to v2, we can control how many tasks can be started and stopped, and in which order
- ECS Rolling Update – Min 50%, Max 100%
- ECS Rolling Update – Min 100%, Max 150%
## ECS tasks invoked by Event Bridge
![](https://data.terabox.com/thumbnail/eb044c0e89de29e6cf5db1ac7f88b854?fid=4401547290288-250528-201258706744272&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-3hLLLBu3FtQjJwFIb4mPToDFXHE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=170998566491253215&dp-callid=0&time=1667372400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## ECS tasks invoked by Event Bridge Schedule
![](https://data.terabox.com/thumbnail/5aafa72148f98892c13935b471809a92?fid=4401547290288-250528-356719538095008&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-vLe5JMrK6m2Fb0h7uF7hqhfx6WQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=171121987080259285&dp-callid=0&time=1667372400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## ECS – SQS Queue Example
![](https://data.terabox.com/thumbnail/63a3a1c23bd069dab3cd6cf503295af7?fid=4401547290288-250528-965009520453152&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Sejp3wYCnIbOc7fmCs8LuosAAOM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=171169811535657056&dp-callid=0&time=1667372400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon ECR
- ECR = Elastic Container Registry
- Store and manage Docker images on AWS
- Private and Public repository (Amazon ECR Public Gallery https://gallery.ecr.aws)
- Fully integrated with ECS, backed by Amazon S3
- Access is controlled through IAM (permission errors => policy)
- Supports image vulnerability scanning, versioning, image tags, image lifecycle, …
![](https://data.terabox.com/thumbnail/744d52e50e044f3bc319b5a56c268063?fid=4401547290288-250528-423578700316295&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Stux1CyIdedE92n7wDK4HI8M5Zw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172053799819305401&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon EKS Overview
- Amazon EKS = Amazon Elastic Kubernetes Service
- It is a way to launch managed Kubernetes clusters on AWS
- Kubernetes is an open-source system for automatic deployment, scaling and management of containerized (usually Docker) application
- It’s an alternative to ECS, similar goal but different API
- EKS supports EC2 if you want to deploy worker nodes or Fargate to deploy serverless containers
- Use case: if your company is already using Kubernetes on-premises or in another cloud, and wants to migrate to AWS using Kubernetes
- Kubernetes is cloud-agnostic (can be used in any cloud – Azure, GCP…)
- For multiple regions, deploy one EKS cluster per region
## Amazon EKS - Diagram
![](https://data.terabox.com/thumbnail/6c0f08054133250536042dd551a8e5e2?fid=4401547290288-250528-1084799678295955&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-wXcpihlVzkua4fOi1ymaSgXrZJo%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172116488226340484&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
