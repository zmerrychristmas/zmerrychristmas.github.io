---
title: AWS Integration & Messaginng
tags:
- sqs
- SQS
- Queue
- Long Polling
- decouple
categories:
- Fullstack
- Blogging
- AWS
---

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
