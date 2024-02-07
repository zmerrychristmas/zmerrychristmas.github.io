---
title: Serverless Overview
tags:
- lambda
- dynamodb
- api
- APIGateway
- Cognito
- SAM
- CodeDeploy
categories:
- Fullstack
- Architect
- AWS
---

# Serverless Overview
- Serverless is a new paradigm in which the developers don’t have to manage servers anymore…
- They just deploy code
- They just deploy… functions !
- Initially... Serverless == FaaS (Function as a Service)
- Serverless was pioneered by AWS Lambda but now also includes anything that’s managed: “databases, messaging, storage, etc.”
- Serverless does not mean there are no servers… it means you just don’t manage / provision / see them
## Serverless in AWS
AWS Lambda, DynamoDB, AWS Cognito, AWS API Gateway, Amazon S3, AWS SNS & SQS, AWS Kinesis Data Firehose, Aurora Serverless, Step Functions, Fargate
![](https://data.terabox.com/thumbnail/10726a0f5baaf3a2ce7a489cfcda381b?fid=4401547290288-250528-947098034070559&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-aaoRPwLqf5eF08YF3hefH7JTipM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172253665265587711&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Why AWS Lambda
- EC2
    - Virtual Servers in the Cloud
    - Limited by RAM and CPU
    - Continuously running
    - Scaling means intervention to add / remove servers
- Amazon Lambda
    - Virtual functions – no servers to manage!
    - Limited by time - short executions
    - Run on-demand
    - Scaling is automated!
## Benefits of AWS Lambda
- Easy Pricing
    - Pay per request and compute time
    - Free tier of 1,000,000 AWS Lambda requests and 400,000 GBs of compute time
- Integrated with the whole AWS suite of services
- Integrated with many programming languages
- Easy monitoring through AWS CloudWatch
- Easy to get more resources per functions (up to 10GB of RAM!)
- Increasing RAM will also improve CPU and network!
## AWS Lambda language support
- Node.js, python, java, C#, Golang, C# Powershell, Ruby, Custom Runtim API (community supported, example Rust)
- Lambda Container Image
    - The container image must implement the Lambda Runtime API
    - ECS / Fargate is preferred for running arbitrary Docker images
## AWS Lambda Integrations Main ones
![](https://data.terabox.com/thumbnail/519fd4c34d130103b429865ad076d7ae?fid=4401547290288-250528-221062306131799&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BTsOEpNGAmVYLWA7Q%2bVz6MgS4lU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172422911295416502&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/519fd4c34d130103b429865ad076d7ae?fid=4401547290288-250528-221062306131799&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BTsOEpNGAmVYLWA7Q%2bVz6MgS4lU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172422911295416502&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/512481c46588d6f3f68defd415ae10f1?fid=4401547290288-250528-725580866278910&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-QNNHasZb3vWm661Q7dtDjRJ%2fnYk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172478755750115268&dp-callid=0&time=1667376000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Lambda Pricing: example
- You can find overall pricing information [here](https://aws.amazon.com/lambda/pricing/):
- Pay per calls:
    - First 1,000,000 requests are free
    - $0.20 per 1 million requests thereafter ($0.0000002 per request)
- Pay per duration: (in increment of 1 ms)
    - 400,000 GB-seconds of compute time per month for FREE
    - == 400,000 seconds if function is 1GB RAM
    - == 3,200,000 seconds if function is 128 MB RAM
    - After that $1.00 for 600,000 GB-seconds
- It is usually very cheap to run AWS Lambda so it’s very popular
## AWS Lambda Limits to Know - per region
- Execution:
    - Memory allocation: 128 MB – 10GB (1 MB increments)
    - Maximum execution time: 900 seconds (15 minutes)
    - Environment variables (4 KB)
    - Disk capacity in the “function container” (in /tmp): 512 MB
    - Concurrency executions: 1000 (can be increased)
- Deployment:
    - Lambda function deployment size (compressed .zip): 50 MB
    - Size of uncompressed deployment (code + dependencies): 250 MB
    - Can use the /tmp directory to load other files at startup
    - Size of environment variables: 4 KB
## Lambda@Edge
- You have deployed a CDN using CloudFront
- What if you wanted to run a global AWS Lambda alongside?
- Or how to implement request filtering before reaching your application?
- For this, you can use Lambda@Edge:
    - deploy Lambda functions alongside your CloudFront CDN
    - Build more responsive applications
    - You don’t manage servers, Lambda is deployed globally
    - Customize the CDN content
    - Pay only for what you use
## Lambda@Edge
- You can use Lambda to change CloudFront requests and responses:
    - After CloudFront receives a request from a viewer (viewer request)
    - Before CloudFront forwards the request to the origin (origin request)
    - After CloudFront receives the response from the origin (origin response)
    - Before CloudFront forwards the response to the viewer (viewer response)
    - You can also generate responses to viewers without ever sending the request to the origin
## Lambda@Edge: Global application
![](https://data.terabox.com/thumbnail/ea10c542d5a18ddee62cdd10158bceaf?fid=4401547290288-250528-862298497884711&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-k8LmjznUW8RYbTPShunzRWbOihI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=172984914924138939&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Lambda@Edge: Use Cases
- Web security and privacy
- Dynamic Web application at the edge
- Search Engine Optimization (SEO)
- Intelligently Route Across Origin and Data Centers
- Bot Mitigation at the Edge
- Realtime image transformation
- A/B Testing
- User Authentication and Authorization
- User Prioritization
- User Tracking andAnalytics
## Amazon DynamoDB
- Fully managed, highly available with replication across multiple AZs
- NoSQL database - not a relational database
- Scales to massive workloads, distributed database
- Millions of requests per seconds, trillions of row, 100s of TB storage
- Fast an consistent in performance (low latency on retriieval)
- Integrated with IAM for security, authorization and administration
- Enables event driven programming with DynamoDB Streams
- Low cost and auto-scaling capabilities
- Standard & Infrequent Access (IA) Table Class
## DynamoDB - Basics
- DynamoDB is made of Tables
- Each table has a Primary Key (must be decided at creation time)
- Each table can have an infinite number of items (= rows)
- Each item has attributes (can be added over time – can be null)
- Maximum size of an item is 400KB
- Data types supported are:
    - Scalar Types – String, Number, Binary, Boolean, Null
    - Document Types – List, Map
    - Set Types – String Set, Number Set, Binary Set
## DynamoDB – Table example
![](https://data.terabox.com/thumbnail/197349046941d4e878dc0e2b4f331a51?fid=4401547290288-250528-511800935978111&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-%2bLDR5WkVnHqCjFpT1v2q%2fWGWbDs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173184622648670272&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DynamoDB – Read/Write Capacity Modes
- Control how you manage your table’s capacity (read/write throughput)
- Provisioned Mode (default)
    - you specify the number of reads/writes per second
    - You need to plan capacity beforehand
    - Pay for provisioned Read Capacity Units (RCU) & Write Capacity Units (WCU)
    - Possibility to add auto-scaling mode for RCU & WCU
- On-Demand Mode
    - Read/writes automatically scale up/down with your workloads
    - No capacity planning needed
    - Pay for what you use, more expensive ($$$)
    - Great for unpredictable workloads
## DynamoDB Accelerator (DAX)
- Fully-managed, highly available, seamless in-memory cache for DynamoDB
- Help solve read congestion by caching
- Microseconds latency for cached data
- Doesn’t require application logic modification (compatible with existing DynamoDB APIs)
- 5 minutes TTL for cache (default)
![](https://data.terabox.com/thumbnail/c969c020c222759d0d25e5e300d2bec7?fid=4401547290288-250528-1102980644925740&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-9%2frQE6Tn9TkG8sgXHnLd9aWZUU8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173255725376638758&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DynamoDB Accelerator (DAX) vs. ElastiCache
![](https://data.terabox.com/thumbnail/bf154e6dfd23c2ae0858105f1498d31e?fid=4401547290288-250528-863467490254966&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-ryIJGbdQWHgMlWIji5nJUKT3WsQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173294341794884916&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DynamoDB Streams
- Ordered stream of item-level modifications (create/update/delete) in a table
- Stream records can be:
    - Sent to Kinesis Data Streams
    - Read by AWS Lambda
    - Read by Kinesis Client Library applications
- Data Retention for up to 24 hours
- Use cases:
    - react to changes in real-time (welcome email to users)
    - Analytics
    - Insert into derivative tables
    - Insert into ElasticSearch
    - Implement cross-region replication
## DynamoDB Streams
![](https://data.terabox.com/thumbnail/c86c603315bea351a1e3525b67a005f5?fid=4401547290288-250528-865188936361475&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-jrm6fpykxY%2beYzIEOVrt385FyY0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173467394133096235&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DynamoDB Global Tables
- Make a DynamoDB table accessible with low latency in multiple-regions
- Active-Active replication
- Applications can READ and WRITE to the table in any region
- Must enable DynamoDB Streams as a pre-requisite
## DynamoDB – Time To Live (TTL)
- Automatically delete items after an expiry timestamp
- Use cases: reduce stored data by keeping only current items, adhere to regulatory obligations, …
## DynamoDB - Indexes
- Global Secondary Indexes (GSI) & Local Secondary Indexes (LSI)
- High level: allow to query on attributes other than the Primary Key
- With Indexes, we can query by Game ID, Game_TS, Score, Result, etc…
## DynamoDB - Transactions
![](https://data.terabox.com/thumbnail/00afbdeee34f488e3a99cf077c2cd442?fid=4401547290288-250528-400793248914765&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-YBECyT7sWh4pQPzF0Br173HU%2bdc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173578792295260107&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Example: Building a Serverless API
![](https://data.terabox.com/thumbnail/59ea347de843da8e619e0591c2aea408?fid=4401547290288-250528-880473845298293&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-v2SmPO%2fmstXcJTFg8SS7qIBQH6k%3d&expires=8h&chkbd=0&chkv=0&dp-logid=173594795437690566&dp-callid=0&time=1667379600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS API Gateway
- AWS Lambda + API Gateway: No infrastructure to manage
- Support for the WebSocket Protocol
- Handle API versioning (v1, v2…)
- Handle different environments (dev, test, prod…)
- Handle security (Authentication and Authorization)
- Create API keys, handle request throttling
- Swagger / Open API import to quickly define APIs
- Transform and validate requests and responses
- Generate SDK and API specifications
- Cache API responses
## API Gateway – Integrations High Level
- Lambda Function
    - Invoke lambda function
    - Easy way to expose REST API backed by AWS Lambda
- HTTP
    - Expose HTTP endpoints in the backend
    - Example: internal HTTP API on premise, Application Load Balancer...
    - Why? Add rate limiting, caching, user authentications, API keys, etc...
- AWS Service
    - Expose any AWS API through the API Gateway?
    - Example: start an AWS Step Function workflow, post a message to SQS
    - Why? Add authentication, deploy publicly, rate control…
## API Gateway - Endpoint Types
- Edge-Optimized (default): For global clients
    - Requests are routed through the CloudFront Edge locations (improves latency)
    - The API Gateway still lives in only one region
- Regional:
    - For clients within the same region
    - Could manually combine with CloudFront (more control over the caching strategies and the distribution)
- Private:
    - Can only be accessed from your VPC using an interface VPC endpoint (ENI)
    - Use a resource policy to define access
## API Gateway – Security
- IAM Permissions
    - Create an **IAM policy** authorization and attach to User / Role
    - API Gateway verifies IAM permissions passed by the calling **application**
    - Good to provide access within your own infrastructure
    - Leverages “Sig v4” capability where IAM credential are in **headers**
![](https://data.terabox.com/thumbnail/d3d7fed6f33a7c720503912946bf6568?fid=4401547290288-250528-692024638766124&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-RbiwhqbrN5WPwJg7dsEqUNU1YXY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=174696579442963234&dp-callid=0&time=1667386800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Lambda Authorizer (formerly Custom Authorizers)
    - Uses AWS Lambda to validate the token in **header** being passed
    - Option to cache result of authentication
    - Helps to use OAuth / SAML / 3 rd party type of authentication
    - Lambda must return an **IAM policy** for the user
- Cognito User Pools

    - Cognito fully manages user lifecycle
    - API gateway verifes identity automatically from AWS Cognito
    - No custom inplementation required
    - Cognito only helps with authentication, not authorization
![](https://data.terabox.com/thumbnail/2ac779c71cb601b016151126eae8e14a?fid=4401547290288-250528-874150203205777&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-2RDWxOjVhZQxt0nWmZ9Z7T8bHL0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=174771336702856984&dp-callid=0&time=1667386800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## API Gateway – Security – Summary
- IAM:
    - Great for users / roles already within your AWS account
    - Handle authentication + authorization
    - Leverages Sig v4
- Custom Authorizer
    - Great for 3 rd party tokens
    - Very flexible in terms of what IAM policy is returned
    - Handle Authentication + Authorization
    - Pay per Lambda invocation
- Pay per Lambda invocation
    - You manage your own user pool (can be backed by Facebook, Google login etc…)
    - No need to write any custom code
    - Must implement authorization in the backend
## AWS Cognito
- We want to give our users an identity so that they can interact with our
application.
- Cognito User Pools:
    - Sign in functionality for app users
    - Integrate with API Gateway
- Cognito Identity Pools(Federate Identity)
    - Provide AWS credentials to users so they can access AWS resources directly
    - Integrate with Cognito User Pools as an identity provider
- Cognito Sync
    - Synchronize data from device to Cognito.
    - May be deprecated and replaced by AppSync
## AWS Cognito User Pools (CUP)
- Create a serverless database of user for your mobile apps
- Simple login: Username (or email) / password combination
- Possibility to verify emails / phone numbers and add MFA
- Can enable Federated Identities (Facebook, Google, SAML…)
- Sends back a JSON Web Tokens (JWT)
- Can be integrated with API Gateway for authentication
## AWS Cognito – Federated Identity Pools
- Goal
    - Provide direct access to AWS Resources
from the Client Side
- How:
    - Log in to federated identity provider – or
remain anonymous
    - Get **temporary** AWS credentials back from
the Federated Identity Pool
    - These credentials come with a **pre-defined
        IAM policy** stating their permissions
- Example:
    - provide (temporary) access to write to S3
bucket using Facebook Login
## AWS Cognito Sync
- Deprecate - use AWS AppSync now
    - Store preferences, configuration, state of app
    - Cross device synchronization (any platform – iOS, Android, etc…)
    - Offline capability (synchronization when back online)
- Requires Federated Identity Pool in Cognito (not User Pool)
    - Store data in datasets (up to 1MB)
    - Up to 20 datasets to synchronise
## AWS SAM - Serverless Application Model
- SAM = Serverless Application Model
- Framework for developing and deploying serverless applications
- All the configuration is YAML code:
    - Lambda Functions
    - DynamoDB tables
    - API Gateway
    - Cognito User Pools
- SAM can help you to run Lambda, API Gateway, DynamoDB locally
- SAM can use CodeDeploy to deploy Lambda functions
