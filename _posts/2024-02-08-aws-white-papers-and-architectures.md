---
title: AWS White Papers and Architectures
tags:
- aws
- Architecture
categories:
- Fullstack
- Architect
- AWS
---

# White Papers and Architectures
Well Architected Framework, Disaster Recovery, etc...
## Section Overview
- Well Architected Framework Whitepaper
- Well Architected Tool
- AWS Trusted Advisor
- Reference architectures resources (for real-world)
- Disaster Recovery on AWS Whitepaper
## Well Architected Framework General Guiding Principles
- https://aws.amazon.com/architecture/well-architected
- Stop guessing your capacity needs
- Test systems at production scale
- Automate to make architectural experimentation easier
- Allow for evolutionary architectures
    - Design based on changing requirements
- Drive architectures using data
- Improve through game days
    - Simulate applications for flash sale days
## Well Architected Framework 66 Pillars
1. Operational Excellence
2. Security
3. Reliability
4. Performance Efficiency
5. Cost Optimization
6. Sustainability
They are not something to balance, or trade-offs, they’re a synergy
## AWS Well-architected Tool
Free tool to review your architectures against the 6 pillars Well-Architected Framework and adopt architectural best practice
- How does it work?
    - Select your workload and answer questions
    - Review your answers against the 66 pillars
    - Obtain advice: get videos ad documentations, generate a report, see the results iin a dashboard
- Let's have a look: https://console.aws.amazon.com/wellarchitected
## Trusted Advisor
- No need to install anything - high level AWS account assessment
- Analyze your AWS accounts and provides recommendation:
![](https://ibb.co/Xz3GP4j)
- Core checks and recommendations - all customers
- Can enable weekly email notification from the console
- Full Trusted Advisor: Available for business & Enterprise support plans
    - Ability to set CloudWatch alarms when reaching limits
    - Programmatic Access using AWS Support API
## Trusted Advisor Checks Examples
- Cost Optimization
    - Low utilization EC2 instances, idle load balancers, under-utilized EBS volumes...
    - Reserved instances & savings plans optimizations
- Performance:
    - High utilization EC2 instances, CloudFront CDN optimizations
    - EC2 to EBS throughput optimizations, Alias records recommendations
- Security:
    - MFA enabled on Root Account, IAM key rotation, exposed Access Keys
    - S3 Bucket permissions for public access, security groups with unrestricted ports
- Fault Tolerance:
    - EBS snapshots age, Availability Zone balance
    - ASG Multi-AZ, RDS Multi-AZ, ELB configuration,,,
- Service Limits
## More Architecture Examples
- We explored the most important architectural patterns:
    - Classic: EC2, ELB, RDS, ElastiCache, etc ...
    - Serverless: S3, Lambda, DynamoDB, CloudFront, API Gateway, etc...
- If you want to see more AWS architectures:
    - ![https://aws.amazon.com/architecture/](https://aws.amazon.com/architecture/)
    - ![https://aws.amazon.com/solutions/](https://aws.amazon.com/solutions/)
