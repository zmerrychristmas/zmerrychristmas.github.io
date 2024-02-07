---
title: AWS Question and Answer Practice
tags:
- aws
- FAQ
categories:
- Fullstack
- Architect
- AWS
---

- What is ACM?
    - The AWS certtificates manager is a service which allow the creation, managerment and renewable of certificates. It allow deployment certificcatte onto support AWS service such as CloudFront and ALB.
- What is CloudFronnt Security OAI and CCustom origin
    - OAI is features where virtual identities can be created, associatted with a CCloudFront Distributionn and deployed to edge locations.
      Access to ann S3 buckket cann be connttrolled by using these OAI's allowinng access from an OAI, and usinnng an implicit DENY for everythinng else. They are generally used to esure o direct access tto S3 objecct is allowed when usinng preivate CF Distributions
- What is Lambda@edge
    - Lambda@edge allows cloudfront to run lambda functionn at CCloudFront edge loccations to modify traffic between the viewer and edge locations and origins
- What is Global Accelerator?
    - AWS Global Acccelerator is designed to improve global network performance by offerinng entry point on to thhe global AWS transit network as close to ccustomers as possible using Anycast IP addresses
- Which type of S3 encryption shows as AES256?
    - SSE-S3
- Which S3 Storage class is suitable for data which is easily replaced (choose the most cost effective)?
  - S3 One Zone-IA
- Which Object class in S3 is ideal for uncertain access and low admin overhead?
  - S3 inteligent tiering
- What is the cheapest S3 storage class for important data which need to be retained for long periods and is rarely accessed?
  - S3 Glacier
- Which steps are required to allow an S3 bucket to operate as a website (choose all which apply) ?
  1. Upload Web file
  2. Set index and error documents
  3. Enable static web hosting
  4. Disable block public access setting
  5. Add a bucket policy
- What S3 feature allows objects storage classes to be changed and objects deleted automatically?
  - S3 Lifecycle policy
- What is the default limit of the number of S3 buckets in an AWS account?
  - 100
- How large can an object in S3 be ? and what (if any) limits are there on the number of objects in a bucket?
  - 5TB, no limit object bucket
- What S3 feature needs to be enabled to allow Cross-Region Replication (CRR)?
  - Versioning
- What S3 feature can be used to grant external accounts access to an S3 bucket?
  - Resource Policy
- Which type of encryption allows for role separation where an S3 Full Admin might not be able to decrypt objects?
  - SSE-KMS
- Which type of encryption is where AWS perform encryption operations but DON'T hold any keys?
  - SSE-C
- What type of encryption means AWS perform the encryption operations and handle key creation & management?
  - SSE-S3
- What feature is required to allow CRR to function?
  - Versioning
- What happens when an object is deleted in a bucket with versioning enabled?
  - A delete maker is added
- What is Network access control list(ACL) ?
  - NACL: is optional layer of security for your VPC that acts as a firewall for controlling traffic in and out on one or more subnet. You might setup network ACLs with rules similar to your security groups in order to add an additional layer of security to your VPC.(stateless)
- What is Seccurity Group(stateful)?
  - Are another seccurity feature of AWS VPC ... only unlike NACL they are attached to AWS Resources, nnot VPC subnets
  SG offer a few advagesvs NACLs in that they can recognize AWS resources and filter based on them, they can reference other SGs and also themselves
  But SG are not cappable of explicy traffic - often rquire assistance NACL
