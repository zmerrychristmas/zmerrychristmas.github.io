---
title: Serverless Architectures Examples
tags:
- serverless
- bigdata
- pipeline
- Micro Services
- kinesis
- firehorse
- athena
- QuickSight
- RedShift
categories:
- Fullstack
- Architect
- AWS
---

# Serverless Architectures
## Serverless hosted website: MyBlog.com
- This website should scale globally
- Blogs are rarely written, but often read
- Some of the website is purely static files, the rest is a dynamic REST API
- Caching must be implement where possible
- Any new users that subscribes should receiv a welcom email
- Any photo uploaded to the blog should have a thumbnail generated
- S3 static website, API Gateway, ElasticeCahce for S3, Kinesis with SNS, DynamoDB, Simple Email Service (SES)
## Serving static content, globally
![](https://data.terabox.com/thumbnail/4e2a9e800b0e057404634aecbbd4c2ee?fid=4401547290288-250528-951766205690836&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-9quRMYFhIcaumlta3Obu51Yig9M%3d&expires=8h&chkbd=0&chkv=0&dp-logid=189667894333590370&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Adding a public serverless REST API
![](https://data.terabox.com/thumbnail/691271234a018c7591b6f1e9c405cc7c?fid=4401547290288-250528-847803645672313&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-txuDF1Y9b2YYSXgzu4IGz1neBuA%3d&expires=8h&chkbd=0&chkv=0&dp-logid=189717183445838129&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Leveraging DynamoDB Global Tables
![](https://data.terabox.com/thumbnail/a75bb4d41b7a15c138bb76e134ef878d?fid=4401547290288-250528-1064093909719249&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-7M%2blohKnXt7b7ab31UTnzhY%2b%2fQ4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=189757368263404468&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## User Welcome email flow
![](https://data.terabox.com/thumbnail/91248dde284150bffb791864deca73f4?fid=4401547290288-250528-230948819063834&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-N7XhIeBYixkHUGy%2f2JePSobyPJc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=189803645914567498&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Thumbnail Generation flow
![](https://data.terabox.com/thumbnail/95bb252d966e73616e7d1d4441564a91?fid=4401547290288-250528-1045146208196303&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-X%2b%2bc%2bHT7cuFdQl7ClT696g5Lnwc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=189816351672764764&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
SQS, SNS, S3, Lambda, S3, CLoudFront
## AWS Hosted Website Summary
- We've seen static content being distributed using **CloudFront** with **S3**
- The REST API was serverless, didn't need Cognito because public
- We leveraged a Global DynamoDB table to serve the data globally
- (we could have used Aurora Global Database)
- We enabled **DynamoDB streams** to trigger a **Lambda** function
- The lambda function had an **IAM role** which could use SES
- **SES** (Simple Email Service) was used to send emails in a serverless way
- S3 can trigger **SQS/SNS/Lambda** to notify events
## Micro Services architecture
- We want to switch to a micro service architecture
- Many services interact with each other directly using a REST API
- Each architecture for each micro service may vary in form and shape
- We want a micro-service architecture so we can have a leaner development lifecycle for each service
- API Gateway, AWS Dynamo global stream, Aurora Global, Lambda, Route53, Elastic Load Balancer, ElasticCache
## Micro Services Environment
![](https://data.terabox.com/thumbnail/6fee28bc68d720535a5efed65d30c70d?fid=4401547290288-250528-326999378940011&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-f30JlQ%2ffcAYGNW7TfbOqvbib8EE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190011690776592671&dp-callid=0&time=1667440800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Dicussions on Micro Services
- You are free to design each micro-service the way you want
- Synchronous patterns: API Gateway, Load Balancers
- Asynchronous patterns: SQS, Kinesis, SNS, Lambda triggers (S3)
- Challenges with micro-services:
    - repeated overhead forr creating each new microservice
    - issues with optimizing server density/utilization
    - complexity of running multiple versions of multiple microservices simultaneously
    - complexity of running multiple versions of multiple microservices simultaneouly
    - proliferation of client-side code requirements to integrate with many separate services
- Some of the challenges are solved by Serverless patterns
    - API Gateway, Lambda scale automatically and you pay per usage
    - You can easily clone API, reproduce environments
    - Generated client SDK through Swagger integration for the API Gateway
## Distributing paid content
- We sell videos online and users have to paid to buy videos
- Each videos can be bought by many different customers
- We only want to distribute videos to users who are premium users
- We have a database of premium users
- Links we send to premium users should be short lived
- Our application is global
- We want to be fully serverless
- DynamoDB, Lambda, REST HTTPS, Cognito, CloudFront, OAI
## Start simple, premium user service
![](https://data.terabox.com/thumbnail/590f75e5d0bc84b7fc607fe046966bf9?fid=4401547290288-250528-858217158214982&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-luB8lnl2Yt%2faXPNTP6REAcehOHU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190886024912918826&dp-callid=0&time=1667444400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Add authentication
![](https://data.terabox.com/thumbnail/1266c830674a0ac9d8f0e7e50aa80655?fid=4401547290288-250528-854768855066610&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-W5a9KuIRDfWn3Kp%2bKHMj53D3Uvs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190916231334449227&dp-callid=0&time=1667444400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Add Videos Storage Service
![](https://data.terabox.com/thumbnail/ea938cc9c397f8050309303c792c7df3?fid=4401547290288-250528-54536963377223&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-c2%2fqOG%2bvAdbQDim9s498MAvzN5M%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190929823374986364&dp-callid=0&time=1667444400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Distribute Globally and Secure
![](https://data.terabox.com/thumbnail/a8b3f8dc0123c3f943431bb1c3f9b973?fid=4401547290288-250528-148639571993878&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-vrgYuCWTQpHThT4%2b1FCGeLKKcls%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190952033805736429&dp-callid=0&time=1667444400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Distribute Content only to premium users
![](https://data.terabox.com/thumbnail/661cc4e78137d3b993b8fef66a6c4289?fid=4401547290288-250528-804216956392717&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Mxrhlqm2JsqzgdhSyc12%2bpbzWJY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=190980170916373306&dp-callid=0&time=1667444400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Premium User Video service
- We have implemented a fully serverless solution:
    - Cognito for authentication
    - DynamoDB for storing users that are premium
    - 2 serverless applications
        - Premium user registration
        - CloudFront Signed url generator
    - Content is stored in S3 (serverless and scalable)
    - Integrated with CloudFront with OAI for security (users can't bypass)
    - CloudFront can only be used using Signed URLs to prevent unauthorizeed users
    - What about S2 Signed URL? They're not efficient for global access
## Software updates offloading
- We have an application running on EC2, that distributes software updates once in a while
- When a new software update is out, we get a lot of request and the content is distributed in mass over the network. It's very costly
- We don't want to change our application, but want to optimize our cost an CPI, how can we do it?
- ECS, load balancer, Cloudront, S3 + OAI, Lambda, DynamoDB
## Our application current state
- auto scaling group, multi-AZ, Amazon EFS
![](https://data.terabox.com/thumbnail/7e6b6f71690645517015bd1ff4b176d0?fid=4401547290288-250528-888044604045714&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-OfnSU6ZW3HR6RRVrMiZULGikacE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=191293818257225453&dp-callid=0&time=1667448000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Easy way to fix things!
- CloudFront
![](https://data.terabox.com/thumbnail/04fe22713a82e3611872035bfedf0e84?fid=4401547290288-250528-524081006965425&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-gN%2bGPYvEN4S34YJiHKnPnoSvNr0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=191309643829712425&dp-callid=0&time=1667448000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- No changes to architecture
- Will cache software update files at the edge
- Software update files are not dynamic, they're static (never changing)
- Our EC2 instances aren't serverless
- But CloudFront is, and will scale for us
- Out ASG will not scale as much, and we'll save tremendously in EC2
- We'll also save in availability, networl bandwith cost, etc
- Easy way to make an existing application more scalaable and cheaper!
## Big Data Ingestion Pipeline
- We want the ingestion pipeline to be fully serverless
- We want to collect data in real time
- We want to transform the data
- We want to query the tranformed data using SQL
- The reports created using the queries should be in S3
- We want to load that data into a warehouse and create dashboards
- Dynamo realtime, S3 select, Athena, Kinesis Redshift, Kinesis stream, S3 static
## Big Data Ingestion Pipeline
- IoT devices, Kinesis Data streams, Kinesis Data Firehose, AWS Lambda, S3 Bucket, Simple queue Service, AWS Lambda, Athena, S3, Amazon QuickSight, Amazon Redshift
![](https://data.terabox.com/thumbnail/406a4623fbc23d05aa5c4746648c48f2?fid=4401547290288-250528-439202580587160&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-4fA%2fsJFWk1oBOqvbbv1sKN98dqE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=193930661019327492&dp-callid=0&time=1667455200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Big Data Ingestion Pipeline discussion
- **IoT Core** allows you to harvest data from IoT devices
- **Kinesis** is greate for **real-time data collection**
- **Firehose** helps with **data delivery** to S3 in near real-time (1 minutes)
- **Lambda** can help **Firehose** with **data transformation**
- Amazon **S3** can trigger **notifications** to **SQS**
- **Lambda** can **subscrible** to **SQS** (we could have connecter S3 to Lambda)
- **Athena** is a **serverless** SQL service and results are stored in S3
- The **reporting** bucket contains **anlyzed** data and can be used by reporting tool such as AWS **QuickSight**, **Redshift**, etc...
