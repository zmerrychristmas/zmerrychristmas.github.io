---
title: AWS Api gateway, Lambda, Serverless, and Services part I
categories:
- Fullstack
- Architect
- AWS
tags:
- aws
- sqs
- sns
- serverless
- service
- sts
---

# AWS API Gateway
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
    - Invoke Lambda function
    - Easy way to expose REST API backed by AWS Lambda
- HTTP
    - Expose HTTP endpoint in the backend
    - Example: internal HTTP API on premise, Application Load Balancer…
    - Why? Add rate limiting, caching, user authentications, API keys, etc…
- AWS Service
    - Expose any AWS API through the API Gateway?
    - Example: start an AWS Step Function workflow, post a message to SQS
    - Why? Add authentication, deploy publicly, rate control...
## API Gateway - Endpoint Types
- Edge-Optimized (default): For global clients
    - Requests are routed through the CloudFront Edge locations (improves latency)
    - The API Gateway still lives in nly one region
- Regional:
    - For client within the same region
    - Cloud manually combine with CloudFront (more control over the caching strategies and the distribution)
- Private:
    - Can only be accessed from your VPC using an interface VPC endpint (ENI)
    - Use a resource policy to define access
## API Gateway – Security: IAM Permissions
- Create an IAM policy **authorization** and attach to User / Role
- API Gateway verifies IAM permissions passed by the calling application
- Good to provide access within your own infrastructure
- Leverages "Sig v4" capability where IAM credential are in headers
## API Gateway – Security: Lambda Authorizer (formerly Custom Authorizers)
- Uses AWS Lambda to **validate** the token in header being passed
- Option to **cache** result of authentication
- Help to use Oauth / SAML / 3rd party type of authentication
- Lambda must return an IAM policy for the user
![Sample](https://ibb.co/rsGNsWJ "title")
## API Gateway – Security: Cognito User Pools
- Cognito fully manages user **lifecycle**
- API gateway verifies identity **automatically** from AWS Cognito
- No custom implementation required
- Cognito only helps with authentication, not authorization
![](https://ibb.co/Y7ZSyRF "cognito user pools")
## API Gateway – Security – Summary
1. IAM
    - Greate for users/ roles already within your AWS account
    - Handle authentication + authorization
    - Leverages Sig v4
2. Custom Authorizer:
    - Greate for 3rd party tokens
    - Very flexible in terms of what IAM policy is returned
    - Handle Authentication + Authorization
    - Pay per Lambda invocation
3. Cognito User Pool
    - you manage your user pool (can be backed by Facebookm Google login etc...)
    - No need to write any custom code
    - Must implement authorization in the backend

# AWS Integration & Messaginng
SQS, SNS & Kinesis
- When we start deploying multiple applications, they will inevitably need to communicate with one another
- There are two patterns of application communication
    - Synchromous communication (app to app)
    - Asynchronous / Evenbased (app to queue to app)
## Introdution
- Synchronnous between applications can be problematic if there are sudden spikes of traffic
- What if you need to suddenly encode 1000 videos but usually it's 10?
- in that case, it better to decouple your applications,
    - SQS: queue model
    - SNS: pub/sub model
    - Kinesis: real-time streaming model
- These services can scale independently from our application!
## Amazon SQS, What's a queue?
![](https://data.terabox.com/thumbnail/e19ff69d211fc1e51950db00c82dca33?fid=4401547290288-250528-572541249214972&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-LxKWvtxa2erWuhJObtVehWte5ts%3d&expires=8h&chkbd=0&chkv=0&dp-logid=100591921571805435&dp-callid=0&time=1667109600&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SQS - Standard queue
- Oldest offering (over 10 years old)
- Fully managed service, used to decouple applications
- Attributes:
    - unlimited throughput, unlimited number of messages in queue
    - Default retention of message: 4 days, maxximum of 14 days
    - Low latenccy (< 10ms on publish and receive)
    - Limitation of 256kb per message sent
- Can have duplicate messages (at least once delivery, occasionally)
- Can have out of order messages (best effort ordering)
## SQS - product messages
- Produced to SQS using the SDK (SendMessage API)
- The message is persited in SQS until consumer deletes it
- Message retention: default 4 days, upto 14days
- Example:
    - order id
    - customer id
    - any attributes you want
- SQS standard: unlimited throughput
## SQS - Consuming messages
- Consumes (running on EC2 instances, Servers, or AWS lambda)...
- Poll SQS for messages (receive up to 10 messages at a time)
- Process the messages (example: insert the message inyo an RDS database)
- Delete the messages using thhe deleteMessage API
## SQS - Mutiple EC2 Innstances Consumers
- Consumers receive and process messages in parallel
- At least once delivery
- Best effort message ordering
- Consumers delete messages after processig them
- We can scale consumers horzontally to improve throughput of processing
## SQS with auto scaling group (ASG)
![](https://data.terabox.com/thumbnail/60fc2bdc059922b8468ef20723f6a421?fid=4401547290288-250528-497477940432260&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Nog0tlOFfrcPULlinQcUmAysrrs%3d&expires=8h&chkbd=0&chkv=0&dp-logid=102362295374213231&dp-callid=0&time=1667116800&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SQS to decouple between appliccation tiers
![](https://data.terabox.com/thumbnail/f80aa192a0a4dcfaa593961f079adb61?fid=4401547290288-250528-626847050172989&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-qMHNmkaZ9U%2bU7%2f%2bMan0PbbkXzV4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=103471156007648684&dp-callid=0&time=1667120400&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon SQS - Security
- Encryption
    - In-flight encryption using HTTPS API
    - At rest encryption using KMS keys
    - Client side encrytion if the client wants to perform encryptioon/decrytion itself
- Access Controls: IAM policies too regulate access to SQS API
- SQS Access Policies (similiar to S3 bucket policies)
    - Useful for cross account access to SQS queues
    - Useful for allowinng other services (SNS, S3...) to write to an SQS queue
## SQS Queue Access Policy
- Cross Acccount Access
- Publish S3 Event Notifications to SQS Queue
## SQS Message Visiblity Timeout
- After a message is polled by a consumer, it becomes invisible to other consumers
- By default, the "message visibility timeout" is 30 seconds
- That means the message has 30 seconnds to be processed
- After the message visibility timeout is over, the message is "visible" in SQS
![](https://data.terabox.com/thumbnail/f756fc00768fa969d676b2666a2d9de8?fid=4401547290288-250528-188833361974328&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-qcnvC0XfBAT35K3DEt7WJH5vSDY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=132004244208837930&dp-callid=0&time=1667224800&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- If a message is not processed within the visibility timeout, it will be processed twice
- A consumer could call the ChangelMessageVisibility API tto get more time
- If visibility timeout is high (hours), and consumer crashes, re-processing will take ttime
- If visiblity ttimeouut is too low (seconds), we may get duplicates
![](https://data.terabox.com/thumbnail/d47c49082dec86f2e22da592a865975e?fid=4401547290288-250528-638498077057569&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-jdlltFCiGrHAJHxoyKhoPQyKWKE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=132070613337514410&dp-callid=0&time=1667224800&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon SQS - Dead Letter Queue
- If a consumer fails to process a message within the visibility timeout... the message goes back to the queue!
- We can set a threshold of how manny times a message can go back to the queue
- After tthe mmaximumreceivves tthreshold is exceeded, the message goes intto a dead lettter queue (DLQ)
- Userful for debugginng!
- Make sure to process the messages in the DLQ before they expire:
    - Good to sett a rettenttion oof 14days in the DLQ
![](https://data.terabox.com/thumbnail/4716a6d1bd945f1672018cecc0dc3c19?fid=4401547290288-250528-253963689416032&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-V4lCvzDh%2byKWkokdmrzD%2fFpcPWE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=132196486098997097&dp-callid=0&time=1667228400&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SQS DLQ - Redrive to Source
- Feature to help consume messages in the DLQ to understand what is wrong with them.
- When our code is fixed, we can redrive the messages from the DLQ backk into the source queue (or any otther queue) inn batches without writing custtom code
## Amazon SQS - Delay Queue
- Delay a message (consummers don't see it immediately) up to 15 minuttes
- Defaultt is 0 secconnds (message is available rightt away)
- Can set a defaultt at queue level
- Can override tthe defaultt o sennd using the DelaySecccond parameters
## Amazon SQS - Long Polling
- When a consumer requests messages from the queue, it can optioally "wait" for messages to arrive if tthere are nonne in the queue
- This is called long pollinng
- LongPolling dereases the nuumber of API calls made tto SQS while increasign tthe efficiency and reduinng lattenccy of your applicationn
- The wait time can be between 1 se tto 20 sec (20 sec preferable)
- Lonng polling is preferable to short polling
- long polling level using waittimeseconnds

## Amazon SQS – Dead Letter Queue
- If a consumer fails to process a message within the
Visibility Timeout…
- We can set a threshold of how many times a message can go back to the queue
- After the maximumReceives threshold is exceeded, the message goes into a dead letter queue (DLQ)
- Useful for debugging!
- Make sure to process the message in the DLQ before they expire:
    - Good to set a retention of **14days** in the DLQ
## SQS DLQ – Redrive to Source
- Redrive to Source
- **Feature to help consume messages** in the DLQ to understand what is wrong with them
- When our code is fixed, we can redrive the messages from the DLQ back into the source queue (or any other queue) in batches without writing custom code
## Amazon SQS – Delay Queue
- Delay a message up to 15minutes
- Default is 0 seconds
- Can set a default at queue level
- Can override the default on send using the delayseconds parameter
## Amazon SQS - Long Polling
- When a consumer requests messages from the queue, it can optionally "wait" for messages to arrive if there are none in the queue
- This is called long polling
- Longpolling decrease the number of API calls mafe to SQS while increasing the
- The wait time can be between 1 sc to 20 sec
- Long polling is preferable to short polling
- Long polling can be enabled at the queue level or at the API level using WaitTimeSeconds
## SQS – Request-Response Systems
- To implement this pattern: use the SQS Temporary Queue Client
- It leverages virtual queues instead of creating / deleting SQS queues (cost-effective)
![](https://data.terabox.com/thumbnail/dbd7823be2ea09d4c6646487427c332e?fid=4401547290288-250528-836653485996578&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Tn0aACsr41dXjKCENJmAIots4Dw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=146796765169662898&dp-callid=0&time=1667282400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon SQS – FIFO Queue
- FIFO = First In First Out (ordering of messages in the queue)
- Limited throughput: 300 msg/s without batching, 3000 msg/s with
- Exactly-once send capability (by removing duplicates)
- Messages are processed in order by the consumer
## Kinesis Overview
- Makes it easy to collect, process, and analyze streaming data in real-time
- Ingest real-time data such as: Application logs, Metrics, Website clickstreams, IoT telemetry data…
- Kinesis **Data Streams**: capture, process, and store data streams
- Kinesis **Data Firehose**: load data streams into AWS data stores
- Kinesis **Data Analytics**: analyze data streams with SQL or Apache Flink
- Kinesis **Video Streams**: capture, process, and store video streams
## Kinesis Data Streams
![](https://data.terabox.com/thumbnail/53158a28c623e5784fb1ecc95aa40bae?fid=4401547290288-250528-888144365073549&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-nUHbZG%2bm8Up4v28zawpO92Bhg0A%3d&expires=8h&chkbd=0&chkv=0&dp-logid=148630191436730620&dp-callid=0&time=1667289600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Retention between 1 day to 365 days
- Ability to reprocess (replay) data
- Once data is inserted in Kinesis, it can’t be deleted (immutability)
- Data that shares the same partition goes to the same shard (ordering)
- Producers: AWS SDK, Kinesis Producer Library(KPL), Kinesis Agent
- Consumers:
    - Write your own: Kinesis Client Library (KCL), AWS SDK
    - Managed: AWS Lambda, Kinesis Data Firehose, Kinesis Data Analytics

## Kinesis Data Streams – Capacity Modes
- Provisioned mode:
    - You choose the number of shards provisioned, scale manually or using API
    - Each shard get 1MB/s in (or 1000 records per second)
    - Each shard get 2MB/s out (classic or enhanced fan-out consumer)
    - You pay per shard provisioned per hour
- On-demand mode:
    - No need to provision or manage the capacity
    - Default capacity provisioned (4 MB/s in or 4000 records per second)
    - Scales automatically based on observed throughput peak during the last 30days
    - Pay per stream per hour & data in/out per GB
## Kinesis Data Firehose
![](https://data.terabox.com/thumbnail/a87fe08448661bf47728bf5964cdb514?fid=4401547290288-250528-28993844855522&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BXS0G9aKyYcpu5C%2bxeTeU4644sE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=148365350066619248&dp-callid=0&time=1667286000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Fully managed service, no administration, automatic scaling, serverless
    - AWS: Redshift / Amazon S3 / ElasticSearch
    - 3rd party partner: Splunk / MongoDB / DataDog / NewRelic / …
    - Custom: send to any HTTP endpoint
- Pay for data going through Firehose
- **Near Real Time**
    - 60 seconds latency minimum for non full batches
    - Or minimum 32 MB of data at a time
- Supports many data formats, conversions, transformations, compression
- Supports custom data transformations using AWS Lambda
- Can send failed or all data to a backup **S3 bucket**
## Kinesis Data Streams vs Firehose
### Kinesis Data Streams
- Streaming service for ingest at scale
- Write custom code (producer / consumer)
- Realtime (~200ms)
- Manage scaling (shard splitting / merging)
- Data storage for 1 to 365 days
- Suports replay capability
### Kinesis Data Firehose
- Load streaming data into S3 / Redshift /
ES / 3 rd party / custom HTTP
- Fully managed
- Near real-time (buffer time min. 60 sec)
- Automatic scaling
- No data storage
- Doesn’t support replay capability
## Kinesis Data Analytics (SQL application)
![](https://data.terabox.com/thumbnail/60d525fa51afec1e7694a5080ceac9f0?fid=4401547290288-250528-913877153385398&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Cp1mXiL7X1h5dzf%2fBuj2fjgtGnw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=148621121388058704&dp-callid=0&time=1667289600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Perform real-time analytics on **Kinesis Streams** using SQL
- Fully managed, no servers to provision
- Automatic scaling
- Real-time analytics
- Pay for actual consumption rate
- Can create streams out of the real-time queries
- Use cases:
    - Time-series analytics
    - Real-time dashboards
    - Real-time metrics
## Ordering data into Kinesis
- Imagine you have 100 trucks (truck_1, truck_2,.., truck_100) on the road sending their GPS positions regularly into AWS
- You want to consume the data in order for each truck, so that you can track their movment accurately
- How should you send that data into Kinesis?
- Answer: send using a "Partition Key" value of the "truck_id"
- The same key will always go to the same shard
## Ordering data into SQS
- For SQS standard, there is no ordering
- For SQS FIFO, if you don’t use a Group ID, messages are consumed in the order they are sent, with only one consumer
- You want to scale the number of consumers, but you want messages to be "grouped" when they are related to each other
- Then you use a Group ID (similar to Partition Key in Kinesis)
## Kinesis vs SQS ordering
- Let’s assume 100 trucks, 5 kinesis shards, 1 SQS FIFO
- Kinesis Data Streams: (500 consumer)
    - On average you’ll have 20 trucks per shard
    - Trucks will have their data ordered within each shard
    - The maximum amount of consumers in parallel we can have is 5
    - Can receive up to 5 MB/s of data
- SQS FIFO
    - You only have one SQS FIFO queue
    - You will have 100 Group ID
    - You can have up to 100 Consumers (due to the 100 Group ID)
    - You have up to 300 messages per second (or 3000 if using batching)
![](https://data.terabox.com/thumbnail/f346f844d5d9db1b8c51b1ce76f4e060?fid=4401547290288-250528-306468149542926&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-%2bkG8vTfYToNs7SuxQkLzqJTGRUQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=149575350169314786&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/b1fad88a96d1d76899606b95a11ce278?fid=4401547290288-250528-796537850720769&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-m8ZdL15W5%2bcMXJW4bAfPrs5XzYk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=149918803408287026&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon SNS
- What if you want to send one message to many receivers?
![](https://data.terabox.com/thumbnail/61a5422e119285c0aa117312c5d96dc4?fid=4401547290288-250528-226564793143734&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EZJZQCXmS8eP%2bsl5h0BjkWvme9M%3d&expires=8h&chkbd=0&chkv=0&dp-logid=149426414854930996&dp-callid=0&time=1667289600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- The **"event producer"** only sends message to one SNS topic
- As many "event receivers" (subscriptions) as we want to listen to the SNS topic notifications
- Each subscriber to the topic will get all the messages (note: new feature to filter messages)
- Up to 12,500,000 subscriptions per topic
- 100,000 topics limit
## SNS integrates with a lot of AWS services
- Many AWS services can send data directly to SNS for notifications
## Amazon SNS – How to publish
- Topic Publish (using the SDK)
    - Create a topic
    - Create a subscription (or many)
    - Publish to the topic
- Direct Publish (for mobile apps SDK)
    - Create a platform application
    - Create a platform endpoint
    - Publish to the platform endpoint
    - Works with Google GCM, Apple APNS, Amazon ADM…
## Amazon SNS – Security
- Encryption:
    - In-flight encryption using HTTPS API
    - At-rest encryption using KMS keys
    - Client-side encryption if the client wants to perform encryption/decryption itself
- Access Controls: IAM policies to regulate access to the SNS API
- SNS Access Policies (similar to S3 bucket policies)
    - Useful for cross-account access to SNS topics
    - Useful for allowing other services ( S3…) to write to an SNS topic
## SNS + SQS: Fan Out
- Push once in SNS, receive in all SQS queues that are subscribers
- Fully decoupled, no data loss
- SQS allows for: data persistence, delayed processing and retries of work
- Ability to add more SQS subscribers over time
- Make sure your SQS queue accesss policy allows for SNS to write
## Application: S3 Events to multiple queues
- For the same combination of: event type (e.g. object create) and prefix (e.g. images/) you can only have one S3 Event rule
- If you want to send the same S3 event to many SQS queues, use fan-out
![](https://data.terabox.com/thumbnail/3418d292f1d06f3ec06d318c2287e826?fid=4401547290288-250528-994038393814877&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EIAdlE7tgwvm4YaSWOeawoN5lYM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=149836234918496344&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Application: SNS to Amazon S3 through Kinesis Data Firehose
- SNS can send to Kinesis and therefore we can have the following solutions architecture:
![](https://data.terabox.com/thumbnail/07787eb9a8b13863a337796e6739c6c1?fid=4401547290288-250528-698671128515364&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-CJlL04CDEPUSicRlQAlTWx5arOg%3d&expires=8h&chkbd=0&chkv=0&dp-logid=149918803408287026&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Amazon SNS – FIFO Topic
- FIFO = First In First Out (ordering of messages in the topic)
- Similar features as SQS FIFO:
    - **Ordering** by message group ID (all messages in the same group are ordred)
    - **Deduplication** using a Deduplication ID or Content Based Deduplication
- Can only have SQS FIFO queues as subscribers
- Limited throughput (same throughput as SQS FIFO)
## SNS FIFO + SQS FIFO: Fan Out
- In case you need fan out + ordering + deduplication
![](https://data.terabox.com/thumbnail/3ea6ea025180be1a376c8c59fdeff11b?fid=4401547290288-250528-41769958245629&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-f%2b2tgUXgOJUBaUNFca8rXHJk53A%3d&expires=8h&chkbd=0&chkv=0&dp-logid=150238647327959985&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SNS – Message Filtering
- JSON policy used to filter messages sent to SNS topic’s subscriptions
- If a subscription doesn’t have a filter policy, it receives every message
![](https://data.terabox.com/thumbnail/22f88eebfb31c930c37934b8fdab6166?fid=4401547290288-250528-336701414978434&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Q%2bh2vb3%2fyR305uc1cXway1zfF28%3d&expires=8h&chkbd=0&chkv=0&dp-logid=150295095105082411&dp-callid=0&time=1667293200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## SQS vs SNS vs Kinesis
### SQS
- Consumer "pull data"
- Data is deleted after being consumed
- Can have as many workers (consumers) as we want
- No need to provision throughput
- Ordering guarantes only on FIFO queues
- Individual message delay capability
### SNS
- Push data to many subscribers
- Up to 12500000 subcribers
- Data is not persisted (lost if not delivered)
- Pub/sub
- Up to 100000 topics
- No need to provision throughput
- Integrates with SQS for fan-out architecture pattern
- FIFO capability for SQS FIFO
## Kinesis
- Standard: Pull data
    - 2Mb per shard
- Enhanced-fan out: push data
    - 2MB per shard per consumer
- Possibility to replay data
- Meant for real-time big data, analytics and ETL
- Ordering at the shard level
- Data expires aftr X days
- Provisioned mode or on-demand capacity mode
## Amazon MQ
- SQS, SNS are "cloud-native" service, and they're using proprietary protocols from AWS
- Traditional applications running from on-premises may use open protocols such as: MQTT, AMQP, STOMP, Openwire, WSS
- When migrating to the cloud, instead of re-engineering the application to use SQS and SNS, we can use Amazon MQ
- Amazon MQ  = managed Apache ActiveMQ
- Amazon MQ doesn’t “scale” as much as SQS / SNS
- Amazon MQ runs on a dedicated machine, can run in HA with failover
- Amazon MQ has both queue feature (~SQS) and topic features (~SNS)
## Amazon MQ – High Availability
![](https://data.terabox.com/thumbnail/e405f51c992247649bff966cc1e5e2ee?fid=4401547290288-250528-131705074839729&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-eqMIRYs%2fxykOOR7iRUOoprbAVzw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=151478974774550761&dp-callid=0&time=1667300400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)

# SERVERLESS AND APPLICATION SERVICES
- Tiered Architecture
- When we start deploying multiple applications, they will inevitably need to communicate with one another.
- There are two patterns of application communication.
    - Evolving with queues
    - Event-driven architecture
## Amazon SQS – Standard Queue
- Oldest offering (over 10 years old)
- Fully managed service, used to decouple applications
- Attributes:
    - Unlimited throughput, unlimited number of messages in queue
    - Default retention of messages: 4 days, maximum of 14 days
    - Low latency (<10 ms on publish and receive)
    - Limitation of 256KB per message sent
- Can have duplicate messages (at least once delivery, occasionally)
- Can have out of order messages (best effort ordering)
## SQS – Producing Messages
- Produced to SQS using the SDK (SendMessage API)
- The message is persisted in SQS until a consumer deletes it
- Message retention: default 4 days, up to 14 days
- Example: send an order to be processed
    - Order id
    - Customer id
    - Any attributes you want
- SQS standard: unlimited throughput
## SQS – Consuming Messages
- Consumers (running on EC2 instances, servers, or AWS Lambda)…
- Poll SQS for messages (receive up to 10 messages at a time)
- Process the messages (example: insert the message into an RDS database)
- Delete the messages using the DeleteMessage API
## Lambda: function as a service
    - You are billed for the duration that a function runs
    - The environment has a direct memory (indirect CPU) allocation
    - Deployment a package with 50MB zipped and 250MB unzipped
    - 512 MB storage available as /tmp
    - Serverless application (S3, API Gateway, Lambda)
    - File Processing (S3, S3 event, lamba)
    - Database Triggers (DynamoDB, Streams, Lambda)
    - Serverless CROn (EventBrige/CWEvents + Lambda)
    - Realtime Stream Data Processing (kinesis + Lambda)
## Lambda in depth:
    - Public Lambda:
    ![](https://data.terabox.com/thumbnail/9fb8e7f5d4deb514c210c436daa33b68?fid=4401547290288-250528-754626766169061&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-AyXAee6ddgI%2bVvNASA%2fyuIDC100%3d&expires=8h&chkbd=0&chkv=0&dp-logid=125173180413113238&dp-callid=0&time=1667199600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
    - Private Lambda:
    ![](https://data.terabox.com/thumbnail/33d179bf393395941a01511d2a744ce3?fid=4401547290288-250528-1097958099823614&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-45Ti2FPZBOQcIaJFI2fcCqPuJCU%3d&expires=8h&chkbd=0&chkv=0&dp-logid=125190523939933141&dp-callid=0&time=1667199600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
        - Lambda run in VPC obey all VPC networking rules
    - Lambda security:
        - Lambda execution roles are IAM roles attached to lambda functions which control the permissions the lambda function receives ...
        - Lambda resource policy controls what services and accounts can invoke lambda functions
    - Lambda Logging:
        - Lambda uses Cloudwatch, cloudwatch logs & x-ray
        - Logs from lambda executions - cloudwatchlogs
        - Metrics - invocation success/failure, retries, latency ... stored in cloudwatch
        - lambda can be integrated with x-ray for distributed tracing
        - Cloudwatch logs requires permissions via execution role
## Lambda in depth: Invocation
- Invocation:
- Synchronous
    - cli / api, client communicates with APIGW , proxied to lambda function
- Asynchronous (typically used when AWS services invoke lambda functions)
    - S3 isn't waitting for any kind of response. The event is generated and S3 stops tracking
    - If processing of the event fails, lambda will retry between 0 and 2 time (configurable). Lambda handles the retry logic
    - The lambda function needs to be idempotent reprocessing a result should have the same end state
![](https://data.terabox.com/thumbnail/287d192ccaaa33ab70bd39efe284f587?fid=4401547290288-250528-848637065930323&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-cQd1uCN6L3W8PuVn%2btcfZB87%2fM8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=125597516564879274&dp-callid=0&time=1667203200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Kinesis data stream: producers(telemetry)
![](https://data.terabox.com/thumbnail/28aa6998b0ebdef94b4e16f253471770?fid=4401547290288-250528-702564787382654&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-kQOc6hfw13wsrP9Vk8%2br4zTlQeA%3d&expires=8h&chkbd=0&chkv=0&dp-logid=125670327781297890&dp-callid=0&time=1667203200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- An execution context is the environment a lambda function run in. A cold start is a full creation and configuration including function code dowload.
![](https://data.terabox.com/thumbnail/a01705e28f64e433d11b34650c680af9?fid=4401547290288-250528-926045713650794&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-LpiObhVLwT29GOMoxt1fK19ih4M%3d&expires=8h&chkbd=0&chkv=0&dp-logid=126228460675791421&dp-callid=0&time=1667203200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Cloudwatch events and eventbridge
- If X happen, or at Y times .. do Z
- Eventbrigde is cloudwatch api v2
- a default event bus for account
- cloudwatch event has only one bus
- eventbrigde have additional bus
- rules match event
- route the events to +1 targets as Lambda
CloudWatch Events and EventBridge have visibility over events generated by supported AWS services within an account.
They can monitor the default account event bus - and pattern match events flowing through and deliver these events to multiple targets.
They are also the source of scheduled events which can perform certain actions at certain times of day, days of the week, or multiple combinations of both - using the Unix CRON time expression format.
Both services are one way how **event driven architectures** can be implemented within AWS.
## SQS – Multiple EC2 Instances Consumers
- Consumers receive and process messages in parallel
- At least once delivery
- Best-effort message ordering
- Consumers delete messages after processing them
- We can scale consumers horizontally to improve throughput of processing
