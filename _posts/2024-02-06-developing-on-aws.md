---
title: Developing on AWS
tags:
- aws
- SDK
- AWS
- AWS SDK
categories:
- Fullstack
- Architect
- AWS
---

# Developing on AWS
## AWS EC2 Instance Metadata
- AWS EC2 Instance Medata is powerful but one of the least known features to developers
- It allows AWS EC2 instances to "learn about themselves" without using an IAM role for that purpose
- THe URL is http://169.254.169.254/latest/meta-data
- You can retrieve the IAM Role name from the metadata, but you cannot retrieve the IAM policy.
- Metadata = Infor about the EC2 instance
- Userdata = launch script of the EC2 instance
## AWS SDK Overview
- What if you want to perform actions on AWS directly from your applications code? (without using the CLI)
- You can use an SDK (software development kit) !
- Official SDKs are...
    - Java
    - .NET
    - Node.js
    - PHP
    - Python (named boto3 / botocore)
    - Go
    - Ruby
    - C++
## AWS SDK Overview
- We have to use the AWS SDK when coding against AWS Services such as DynamoDB
- Fun fact... the AWS CLI uses the Python SDK (boto3)
- The exam experts you to know when you should use an SDK
- We'll pratice the AWS SDK when we get to the Lamba functions
- Good to know: if you don't specify or configure a default region, then us-east-1 will be chosen by default
