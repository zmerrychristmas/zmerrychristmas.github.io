---
title: Virtual Private Cloud (VPC) part 2
tags:
- aws
- vpc
- subnet
- DataSync
- Disaster Recovery Strategies
- PilotLight
- Database Migration Service
- Disaster Recovery
- DMS
categories:
- Fullstack
- Architect
- AWS
---

# Virtual Private Cloud (VPC)
## VPC Components Diagram
![](https://data.terabox.com/thumbnail/47144d3f58bc4b3820a76b0dc6c01a97?fid=4401547290288-250528-727173837262976&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Zc22ueP6yG6M%2b9nYZsoWplvbIaY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=271281899358817708&dp-callid=0&time=1667746800&size=c1680_u1050&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Understanding CIDR - IPv4
- Classless Inter-Domain Routing - a method for allocating IP addresses
- Used in Security Groups rules and AWS networking in general
- They help to define an IP address range:
    - We've seen WW.XX.YY.ZZ/32 => one IP
    - We've seen 0.0.0.0/0 => all IPs
    - But we can define 192.168.0.0/26 => 192.168.0.0 - 192.168.0.63 (64 IP addresses)
- A CIDR consists of two components
- Base IP
    - Represents an IP contained in the range (XX.XX.XX.XX)
    - Example: 1.0.0.0 192.168.0.0
- Subnet Mask
    - Defines how many bits can change in the IP
    - Example: /0, /24, /32
    - Can take two forms:
        - /8 => 255.0.0.0
        - /16 => 255.255.0.0
        - /24 => 255.255.255.0
        - /32 => 255.255.255.255
## Understanding CIDR - Subnet Mask
- The subnet mask basically allows part of the underlying IP to get additional next values from the base IP
- 192.168.0.0 / 32 allows for 1 IP -> 192.168.0.0
- 192.168.0.0 / 31 allows for 2 IP -> 192.168.0.1
- 192.168.0.0 / 30 allows for 4 IP -> 192.168.0.0 -> 192.168.0.3
- 192.168.0.0 / 29 allows for 8 IP -> 192.168.0.7
- 192.168.0.0 / 28 allows for 16 IP -> 192.168.0.15
- ...
- 192.168.0.0 / 16 allows for 65.536 IP -> 192.168.255.255
- 192.168.0.0 / 0 allows for all IPs
## Understanding CIDR – Little Exercise
- 192.168.0.0 / 24 = ... ?
    - 192.168.0.0 – 192.168.0.255 (256 IPs)
- 192.168.0.0/16 = ... ?
    - 192.168.0.0 – 192.168.255.255 (65,536 IPs)
- 134.56.78.123/32 = ... ?
    - Just 134.56.78.123
- 0.0.0.0/0
    - all ips
- When in doubt, use this website: https://www.ipaddressguide.com/cidr
## Public vs Private IP (IPv4)
- The internet assigned number authority (IANA) established certain blocks of IPv4 addresses for the use of private (LAN) and public (internet) addresses
- Private IP can only allow certain values
    - 10.0.0.0 - 10.255.255.255 (10.0.0.0/8) <- in big networks
    - 172.16.0.0 - 172.31.255.255 (172.16.0.0/12) <- AWS default VPC in that range
    - 192.168.0.0 - 192.168.255.255 (192.168.0.0/16) <- e.g, home networks
- All the rest of the IP address on the Internet are Public
## VPC in AWS – IPv4
- VPC = Virtual Private Cloud
- You can have multiple VPCs inn an Ắ region (mã 5 pẻ region - soft limit)
- Max. CIDR per VPC is 5, for each CIDR:
    - Min. size is /28 (16 ip)
    - Max size is /16 (65536 ip)
- Because VP is private, only the Private IPv4 ranges are allowed:
    - 10.0.0.0 - 10.255.255.255 (10.0.0.0/8)
    - 172.16.0.0 - 172.31.255.255 (172.16.0.0/12)
    - 192.168.0.0 - 192.168.255.255 (192.168.0.0/16)
- Your VPC CIDR should NOT overlap with your other network
## VPC – Subnet (IPv4)
- AWS reserves 5 IP addresses (first 4 & last) inn each subnet
- These 5 IP addresses are not available for use and can't be assigned to an EC2 instance
- Example: If IDR block 10.0.0.0/24, then reserved IP addresses are:
    - 10.0.0.0 Network Address
    - 10.0.0.1 reserved by AWS for the VPC router
    - 10.0.0.2 reserved by AWS for mapping to Amazon-provided DNS
    - 10.0.0.3 reserved by AWS for future use
    - 10.0.0.255 Network Broadcast address. AWS doesn't support broadcast in a VPC, therefore the address is reserved
- Example Tip: If you need 29 IP addresses for EC2 instances:
    - You can't choose a subnet of size /27 (32 IP addresses, 32 - 5 = 27 < 29)
    - YOu need to choose a subnet of size /26 (64 IP address, 64 - 5 = 59 > 29)
## Internet Gateway (IGW)
- Allows resources (e.g EC2 instances) in a VP connect to the Internet
- It scales horizontally and is highly available and redundant
- Must be created separately from a VPC
- One VPC can only be attached to one IGW adn vice versa
- Internet Gateway in their own do not allow internet access...
- Route tables must also be edited!
## VPC - Subnet (IPv4)
- AWS reserves 5 IP addresses (first 4 & last) in each subnet
- These 5 IP addresses are not available for use adn can't be assigned to an EC2 instance
- Example if CIDR block 10.0.0.0/24, then reserved IP addresses are:
    - 10.0.0.0 Network Address
    - 10.0.0.1 reserved by AWS for VPC router
    - 10.0.0.2 reserved by AWS mapping Amazon-provided DNS
    - 10.0.0.3 reserved by AWS for future use
    - 10.0.0,255 Network Broadcast Address AWS does not support broadcast inn a VPC therefore the address is reserved
- Example Tip: if you need 29 IP address for EC2 instances:
    - You can't choose a subnet of size /27 (32 IP address, 32-5 = 27 < 29)
    - You need to choose a subnet of size /26 (64 - 5 = 59 > 29)
## Bastion Hosts
- We can use a Bastion Host to SSH into our private EC2 instances
- The bastion is in the public subnet which is then connected to all other private subnet
- Bastion Host security group must be tightened
- Example Tip: Make sure the bastion host oly has port 22 traffic from the IP address you need, not from the security groups of your other EC2 instances
## NAT Instance(outdated but still at the exam)
- NAT = Network Address Transaction
- Allows EC2 instances in private subnet to connect to the internet
- Must be launched in a public subnet
- Must disable EC2 setting: Source / destination check
- Must have Elastic IP attached to it
- Route Tables must be configured to route traffic from private subnet to the NAT instance
## NAT Instance - Comments
- Pre-configured Amazon Linux AMI is available
    - Reached the end of standard support on December 31, 2020
- Not highly  available / resilient setup [ out of the box
    - You need to create ann ASG inn multi-AZ + resilient user-data script
- Internet traffic bandwidth depends on EC2 instance type
- YOu must manage Security Groups & rules
    - Inbound :
        - Allow HTTP/HTTPS coming from Private Subnet
        - Allow SSH from your home network (access is provided through Internet Gateway)
    - Outbound:
        - Allow HTTP/HTTPS traffic to the internet
## NAT Gateway
- AWS-managed NAT, higher bandwidth, high availability, no administration
- Pay per hour for usage and bandwidth
- NATGW is created in a specific Availability Zone, uses an Elastic IP
- Can't be used by EC2 instance in the same subnet (only from other subnets)
- Requires an IGW (Private Subnet => NATGW => IGW)
- 5Gbs of bandwidth with automatic scaling up to 45Gbps
- No Security Groups to manage / required
## NAT Gateway with high availability
- NAT Gateway is resilient within a single Availability Zone
- Must create multiple NAT Gateways inn multiple AZs for fault tolerance
- There is no cross-AZ failover needed because if an AZ goes down it doesn't need NAT
## NAT Gateway vs. NAT Instance

## DNS Resolution in VPC
- DNS Resolution in VPC(enableDnsSupport)
    - Decides if DNS resolution from Route53 resolver server is supported for the VPC
    - True (default): it queries the amazon provider DNS Server att 169.254.169.253 or the reserved IP address at the base of the VPC IPv4 network range plus two
- DNS Hostname (enableDnsHostnames)
    - By default
        - True => default VPC
        - False => newly created VPCs
    - Won't do anything unless enableDnsSupport=true
    - If True, assigns public hostname to EC2 instances if it has a public IPv4
- If you use custom DNS domain names in a Private Hosted Zone in Route 53, you must set both these attributes (enableDnsSupport & enableDnsHostname) to true
## Security Group vs NACLs
## Network Access control list (NACL)
- NACL are like a firewall which control  traffic from and tto subnet
- One NACL per subnet, new subnets are assigned the Default NACL
- You define NACL rules:
    - Rules have a number (1-32766), higher precedence with a lower number
    - First rule match will drive the decision
    - Example: If you define #100 Allow 10.0.0.10/32 and #200 DENY 10.0.0.10/32, the IP address
        will be allowed because 100 has a higher precedence over 200
    - The last rule is an asterisk(\*) and denies a request in case of no rule match
    - AWS recommends adding rules by increment of 100
- Newly created NACLs will deny everything
- NACL are great way of blocking a specific IP address at the subnet level
## Default NACL
- Accepts everything inbound/outbound with the subnets it's associated with
- Do NOT modify the default NACL, instead create custom NACLs
## Ephemeral Ports
- For any two endpoints to establish a connection, they must use ports
- Clients connect to a defined port and expect a response on an ephemeral port
- Different Operation Systems use different port ranges, examples:
    - IANA & MS Windows 10: 49152-65535
    - Many Linux kernels: 327668-60999
## NACL with Ephemeral Ports
## Create NACL rules for each target subnets CIDR
## Security Group vs NACLs
- Security group
    - Operates at the instance level
    - Supports allow rules only
    - Stateful: return traffic is automatically allowed, regardless of any rules
    - All rules are evaluated before deciding whether to allow traffic
    - Applies to an EC2 instance when specified by someone
- NACL
    - Operate at the subnet level
    - Support allow rules and deny rules
    - Stateless: return traffic must be explicitly allowed by rules(thick of ephemeral ports)
    - Rules are evaluated in order (lower to higher) when deciding whether to allow traffic, first match wins
    - Automatically applies to all EC2 instances in the subnet that it's associated with
    ![https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
## VPC - Reachability Analyzer
- A network diagnotics tool that troubleshoots network connectivity between two endpoints in yourVPC(s)
- It builds a model of the network configuration, then checks the reachability based on these configuration (it doesn't send packets)
- When the destination is:
    - Reachable: It produces hop by hop details of the virtual network path
    - Not reachable: It identifies the blocking component(s) (e.g configuration issues in SG, NACLs, Route Tables,...)
- Use cases: troubleshoot connectivity issues, ensure network configuration is intended,...
## VPC Peering
- **Privately** connect two VPCs using AWS's network
- Make them **behave** as if they were in the same network
- Must not have overlapping CIDRs
- VPC Peering connection is NOT **transitive**(Must be established for each VPC that need to communicate with one another)
- You must **update route tables** in each VPC's subnet to ensure EC2 instances can communicate with each other
## VPC Peering – Good to know
- You can create VPC connection between VPCs in different AWS accounts/regions
- You can reference a security group inn a peered VPC (works cross accounts - same region)
## VPC Peering - VPC End Point
## VPC Endpoints (AWS PrivateLink)
- Every AWS service is publicly exposed (public URL)
- VPC Endpoint (powered by AWS PrivateLink) allows you to connect to AWS services using a private network instead of using the public internet
- They're redundant and scale horizontally
- They remove the need of IGW, NATGW,... to access AWS Services
- In case of issues:
    - Check DNS Setting Resolution in your VPC
    - Check Route Tables
## Type of Endpoints
- Interface endpoints
    - Provisions an ENI (private IP address) as an entry point (must attach a Security Group)
    - Supports most AWS services
- Gateway Endpoints
    - Provisions a gateway and must be used as a target in a route table
    - Supports both S3 and DynamoDB
## VPC Flow Logs
- Capture information about IP traffic going into your interfaces:
    - VPC Flow Logs
    - Subnet Flow Logs
    - Elastic network Interface (ENI) Flow Logs
- Helps to monitor & troubleshoot connectivity issues
- Captures network information from AWS managed interface too: ELB, RDS, ElasticCache, Redshift, WorkSpaces,NATGW, Transit Gateway...
## VPC Flow Logs Syntax
- **srcaddr & dstaddr** help identify problematic IP
- **srcport & dsttportt** help identity problematic ports
- Action: Success or failures of request due to Security Group / NACL
- Can be used for analytics on usage patterns, or malicious behavior
- Query VPC flow logs using Athena on S3 or CloudWatch Logs Insights
- Flow Log examples: ![https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-records-examples.html](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-records-examples.html)
## VPC Flow Logs – Troubleshoot SG & NACL issues
### Look at the “ACTION” field
- Incoming Requests
    - Inbound REJECT => NACL or SG
    - Inbound ACCEPT, Outbound REJECT => NACL
- Outgoing request
    - Outbound REJECT => NACL or SG
    - Outbound ACCEPT, Inbound REJECT => NACL
## AWS Site-to-Site VPN
### Virtual Private Gateway (VGW)
- VPN Concentrator on the AWS side of the VPN connection
- VGW is created and attached to the VPC from which you want to create the site to site VP connection
- Possibility to customize the ASN (Autonomous System Number)
### Customer Gateway
- Software application or physical device onn customer side of the VPN connection
- https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html
## Site to Site VPN Connections
- Customer Gateway Device (On-premises)
    - What IP address to use?
        - Public Internet-routable IP address for your Customer Gateway device
        - If it's behind a NAT device that's enabled for NAT traversal (NAT-T), use the public IP address of the NAT device
- Important step: enable Route Propagation for the Virtual Private Gateway inn route table that is associated with your subnets
- If you need yo ping your Ec2 instances from on-premises, make sure you add the ICMP protocol on the inbound of your security groups
## AWS VPN CloudHub
- Provide secure communication between multiple sites, if you have multiple VPN connections
- Low-cost hub and spoke model for primary or secondary network connectivity between different locations(VPN only)
- It's a VPN connection so it goes over the public internet
- To set it up, connect multiple VPN connection on the same VGW, setup dynamic routing and configure route tables
## Direct Connect(DX)
- Provides a dedicated **private** connection from a remote network to your VPC
- Dedicated connection must be setup between your DC and AWS Direct Connect locations
- You need to setup a Virtual Private Gateway on Your VPC
- Access public resources (S3) and private(EC2) on same connection
- Use cases:
    - Increase bandwidth throughput - working with large sets - lower cost
    - More consistent network experience - application using real-time data feeds
    - Hybrid Environments (on prem + cloud)
- Support both IPv4 ad Ipv6
## Direct Connect Gateway
- If you want to setup a Direct Connect to one or more VPC in many different regions (same account), you must use a Direct Connect Gateway
## Direct Connect – Connection Types
- Dedicated Connections:  1Gbps to 10 Gbps capacity
    - Physical ether port dedicated to a customer
    - Request made to AWS first, then completed by AWS Direct Connect Partners
- Hosted Connections: 50Mbps, 500Mbps, to 10 Gbps
    - Connection request are made via AWS Direct Connect Partners
    - Capacity can be added or removed on demand
    - 1,2,5,10, Gbps available at select AWS Direct Connect Partners
- Lead times are often longer than 1 month tto establish a new connection
## Direct Connect – Encryption
- Data inn transit is not encrypted but is private
- AWS Direct Connect + VPN provides an **IPsec-encrypted private connection**
- Good for a extra level of security, but slightly more complex to put in place
## Direct Connect - Resiliency
- High Resiliency Critical workloads (One connection at multiple locations)
- Maximum Resiliency for Critical Workloads
(Maximum resilience is achieved by separate connections
terminating on separate devices in more than one location.)
## Exposing services in yourVPC to otherVPC
- Option1: make it public
    - Goes through the public www
    - Tough to manage access

- Option2: VPC peering
    - Must create many peering relations
    - Open the whole
## AWS PrivateLink (VPC Endpoint Services)
- Most secure & scalable way to expose a service to 1000s of VPC (ow or other accounts)
- Does not require VPC peering, internet gateway, NAT, route tables...
- Requires a network load balancer (service VPC) and ENI (CCustomer VPC) or GWLB
- If the NLB is inn multiple AZ, adn the ENIs inn multiple AZ, the solution is fault tolerant!
## AWS Private Link & ECS
## EC2-Classic & ClassicLink
- EC2-classic: instances run in a single network shared with other customers
- Amazon VPC: your instances run logically isolated to your AWS account
    - Must associate a security group
    - Enables communication using private IPv4 addresses
    - Removes the need to make use of public IPv4 addresses or elastic IP address
- Likely to be distract att the exam
## EC2 Classic & AWS ClassicLik
- Ec2-Classic: instance run in a single network shared with other customers
- Amazon VPC: your instances run logically isolated to your AWS account
- ClassicLink allows you to link EC2-Classic instances to a VPC i your account
    - Must associate a security group
    - Enables communication using private Ipv4 addresses
    - Remove the need to make use of public Ipv4 addresses or Elastic IP addresses
- Likely to be distract at the exam
## Network topologies can become complicated
## Transit Gateway
- For having transitive peering between thousands of VPC and on-premises, hub and spoke (star) connection
- Regional resource, can work cross-region
- Share cross account using Resource Access Manager (RAM)
- YOu can peer Transit Gateway across regions
- Route Tables limit which VPC can talk with other VPC
- Works with Direct Connect Gateway, VPN Connections
- Supports IP Multicast (not supported any other AWS service)
## Transit Gateway: Site to Site VPN ECMP
- ECMP = Equal-cost multi-path routing
- Routing strategy to allow to forward a packet over multiple best path
- Use case: create multiple Site-to-Site VP connection to increase the bandwidth of your connection to AWS
## Transit Gateway: throughput with ECMPTransit Gateway: throughput with ECMP
- VPN to virtual private gateway
- VPN to transit gateway
## Transit Gateway: Share Direct Connect between multiple accounts
## VPC - Traffic Mirroring
- Allows you to capture and inspect network traffic in your VPC
- Route the traffic to security appliances that you manage
- Capture the traffic
    - From (Source) - ENIs
    - To (Targets) - an ENI or a Network Load Balancer
- Capture all packets of your interest (optionally, truncate packets)
- Source and Target can be in the same VPC or different VPCs (VPC Peering)
- Use cases: content inspection, threat monitoring, troubleshooting...
## What is IPvv6
- Ipv4 design for 4.3 billion addresses (they'll be exhausted soon)
- IPv6 is successor of IPv4
- IPv6 is designed to provide 3.4^10 mu 38 unique IP addresses
- Every IPv6 address is public and internet-routable (no private range)
- Format è x.x.x.x.x.x.x.x (x is hexadecimal, range can be from 0000 to ffff)
- Examples:
    - 2001:db8:3333:4444:5555:6666:7777:8888
    - 2001:db8:3333:4444:cccc:dddd:eeee:ffff
    - ::eall 8 segments are zero
    - 2001:db8::ethe last 6 segments are zero
    - ::1234:5678èthe first 6 segments are zero
    - 2001:db8::1234:5678èthe middle 4 segments are zero
## IPv6 in VPC
- Ipv4 cannot be disabled for your VPC and subnets
- You can enable IPv6 (they're public IP addresses) to operate in dual-stack mode
- Your EC2 instances will get at least a private internal IPv4 ad a public IPv6
- They can communicate using either IPv4 or IPv66 to the internet through an Internet gateway
## IPv6 Troubleshooting
- IPv4 cannot be disabled for your VPC and subnets
- So, if you cannot launch an EC2 instance i your subnet
    - it's not because it cannot acquire ann IPv6
    - It's because there are no available IPv4 in your subnet
- Solution: create a new IPv4 CIDR in your subnet
## Egress-only Internet Gateway
- Used for IPv66 only
- (similar to a NAT Gateway but for IPv6)
- Allows instances in your VPC outbound connections over IPv6 while preventing the internet to initiate a Ipv6 connection
- You must update the route tables
## IPv6 Routing
- Internet gateway
- Egress-only Internet Gateway
- Destination, Target
- Nat Gateway
## VPC Section Summary (1/3)
- CIDR - IP range
- VPC - Virtual Private Cloud => we define a list of IPv4 and IPv6 vCIDR
- Subnets - tied to an AZ, we define a CIDR
- Internet Gateway - at the VPC level, provide IPv4 & IPv66 Internet Access
- Route Tables - Must be edited to add routes from subnets to the IGW, VPC Peering Connection, VPC Endpoints,...
- Bastion Host: Public EC2 instance to SSH into that has SSH connectivity to EC2 instances i private subnets
- NAT Instances: give internet access tto EC2 instances in private subnet. Old, must be setup in a public subnet, disable source / Destination check flag
- NAT Gateway: managed by  AWS, provides scalable internet access to private EC2 instances, IPv4 only
- Private DS + Route 53 :  enable DNS Resolution + DNS Hostnames (VPC)
## VPC Section Summary (2/3)
- NACL: stateless, subnet rules for inbound and outbound, do't forget Ephemeral Ports
- Security Groups - Stateful, operate at the Ec2 instance level
- Reachability Analyzer - perform network connectivity testing between AWS resources
- VPC Peering - connect two VPCs with non overlapping CIDR, non-transitive
- VPC Endpoints - Provide private access to AWS services(S3, DynamoDB, cloudFormation, SSM) within a VPC
- VPC Flow Logs - can be setup at the VPC / Subnet / ENI Level, for ACCEPT and REJECT traffic, helps identifying attacks, analyze using Athena or CloudWatch Logs Insights
- Site-to-Site VPC - Set up a Customer Gateway on DC, a Virtual Private Gateway on VPC, and site-to-site VPN over public Internet
- AWS VPN CloudHub: hub and spoke VPN model to connect your sites
## VPC Section Summary (3/3)
- Direct Connect: Setup a Virtual Private Gateway on VPC, and establish a direct private connection to a AWS Direct Connect Location
- Direct Connect Gateway - Setup a Direct Connect to many VPCs in different AWS regions
- AWS PrivateLink / VPC Endpoint Services:
    - Connect services privately from your service VPC to customer VPC
    - Doesn't need VPC Peering, public Internet, AT Gateway, Route Tables
    - Must be used with Network Load Balancer & ENI
- ClassicLink: Connect EC2 - classic EC2 instances privately to your VPC
- Transit Gateway - transitive peering connection for VPC, VPN, DX
- Traffic Mirroring - copy network traffic fromm ENIs for further analysis
- EEgress-only Internet Gateway - Like a NAT Gateway but for IPv6
## Networking Costs in AWS per GB - Simplified
- Use Private IP instead of Public IP for good savings and better network performance
- Use same AZ for maximum savings (at the cost of high availability)
## Minimizing egress traffic network cost
- Egress traffic: outbound traffic (from AWS tto outside)
- Ingress traffic: inbound traffic - from outside too AWS
- Try to keep as much as internet traffic within AWS to minimize costs
- Direct Connect location that are co-located inn the same AWS Region result inn lower cost for egress network
## S3 Data Transfer Pricing – Analysis for USA
- S3ingress:free
- S3 to Internet: $0.09 per GB
- S3 Transfer Acceleration
    - Faster transfer times(50 to 500% better)
    - Additional cost on top of Data transfer Pricing: +$0.04 per GB
- S3 to CloudFront: $0.00 per GB
- CloudFront to Internet: $0.085 per GB(Slightly cheaper than S3)
    - Caching capability (lower latency)
    - Reduce costs associated with S3 RRequests pricing (7x cheaper with CloudFront)
- S3 Cross Region Replication: $0.02 per GB
## NAT Gateway vs Gateway VPC Endpoint
Pricing:
NAT Gateway vs Gateway VPC Endpoint
Subnet 1 route table
Region (us-east-1)
VPC (10.0.0.0/16)
$0.045 NAT Gateway / hour
$0.045 NAT Gateway data processed / GB $0.09 Data transfer out to S3 (cross-region) $0.00 Data transfer out to S3 (same-region)
## Disaster Recovery Overview
- Any event that has a negative impact on a company's business continuity or finances is a disaster
- Disaster recovery (DR) is about preparing for and recovering from a disaster
- What kind of disaster recovery?
    - On-premise => On-premise: traditional DR, and very expensive
    - On-premise -> AWS Cloud: hybrid recovery
    - AWS Cloud Region A => AWS Cloud Region B
- Need to define two terms
    - RPO: Recovery Point Objective
    - RTO: Recovery Time Objective
## Disaster Recovery Strategies
- Backup ad restore
- Pilot Light
- Warm Standby
- Hot Site / Multi Site Approach
## Backup and Restore (High RPO)
## Disaster Recovery – Pilot Light
- A small version of the app is always running in the cloud
- Useful for the critical core (pilot light)
- Very similar tto Backup and Restore
- Faster than backup and restore as critical systems are already up
## Warm Standby
- Full system is up and running, but at minimum size
- Upon disaster, we can scale to production load
## Multi Site / Hot Site Approach
- Very low RTO (minutes or seconds) – very expensive
- Full Production Scale is running AWS and On Premise
## All AWS Multi Region
## Disaster RecoveryTips
- Backup
    - EBS snapshot, RDS automated backups / Snapshots, etc ...
    - Regular pushes to S3/ S3 IA/ Glacier, Lifecycle Policy, Cross Region Replication
    - From O-premise: Snowball or Storage Gateway
- High Availability
    - Use Route53 to migrate DNS over from Region to Region
    - RDS Multi-AZ, ElasticCache Multi-AZ , EFS, S3
    - Site to Site VPN as a recovery fromm Direct Connect
- Replication
    - RDS Replication (Cross Region), AWS Aurora + Global Databases
    - Database replication from on-promise to RDS
    - Storage Gateway
- Automation
    - CloudFormattion / Elastic Beantalk to re-create a whole new environment
    - Recover / Reboot EC2 instances with CloudWatch iif alarm fail
    - AWS Lambda function for customized  automations
- Chaos
    - Netflix has a "simian-army" random terminating EC2
## DMS – Database Migration Service
- Quickly and securely migrate databases to AWS, resilient, self healing
- The source database remains available during the migration
- Supports:
    - Homogeneous migration: ex Oracle to Oracle
    - Heterogeneous migrations:  ex Microsoft SQL Server too Aurora
- Continuous Data Replication using CDC
- You must create an EC2 instance too perform the replication tasks
## DMS Sources and Targets
SOURCES:
- On-Premise and EC2 instances database
Targets:
- DB
## AWS Schema ConversionTool (SCT)
- Convert your Database's Schema from one engine to another
- Example OLTP: (SQL Server or Oracle) to MYSQL, PostgresSQL, Aurora
- Example OLAP: (Teradata or Oracle) to Amazon Redshift
- Prefer computer-intensive instances to optimize data conversions
- You do not need to use SCT if you are migrating the same DB engine
    - Ex: On-premise PostgreSQL => RDS PostgreSQL
    - The DB engine is still PostgreSQL (RDS is the platform)
## DMS - Continuous Replication
## On-Premise strategy with AWS
- Ability to download Amazon Linux 2 AMI as a VM (.iso format)
    - • VMWare, KVM,VirtualBox (Oracle VM), Microsoft Hyper-V
- • VM Import / Export
    - • Migrate existing applications into EC2
    - • Create a DR repository strategy for your on-premisesVMs
    - Can export back the VMs from EC2 to on-premises
- AWS Application Discovery Service
    -  Gather information about your o-premise servers to plan a migration
    - Server utilization and dependency mappings
    - Track with AWS Migration Hub
- AWS Database Migration Service (DMS)
    - replicate On-premise => AWS, AWS => AWS , AWS => O-premise
    - Work with various database technologies (Oracle, Mysql, DynamoDB, etc...)
- AWS Server Migration Service (SMS)
    - Incremental replication of on-premise live servers to AWS
## AWS DataSync
- Move large amount of data from on-premises to AWS
- Can synchronize to: Amazon S3 (any storage classes – including Glacier), Amazon EFS, Amazon FSx (Windows, Lustre...)
- Move data from your NAS or file system via NFS or SMB
- Replication tasks can be scheduled hourly, daily, weekly
- Leverage the DataSync agent to connect to your systems
- Can setup a bandwidth limit
## AWS Backup
- Fully managed service
- Centrally manage and automate across AWS services
- No need to create custom script and manual process
- • Supported services:
    - EC2, EBS
    - S3
    - RDS
    - EFS, DocumentDB, Neptune
    - FSx
    - Storage Gateway
- • Supports cross-region backups
- • Supports cross-account backups
## AWS Backup
- • Supports PITR for supported services
- • On-Demand and Scheduled backups
-  • Tag-based backup policies
- • You create backup policies known as Backup Plans
    - Backup frequency (every 12 hours, daily, weekly, monthly, cron expression)
    - Backup window
    - Transition to Cold Storage (Never, Days, Weeks, Months, Years)
    - Retention Period (Always, Days, Weeks, Months, Years)
![](https://terabox.com/s/1vucCc2Fkjg8452UZcte1dw)
## AWS Backup Vault Lock
- Enforce a WORM (Write Once Read Many) state for all the backups that you store in your AWS Backup Vault
- Additional layer of defense to protect your backups against:
    - Inadvertent or malicious delete operations
    - Updates that shorten or later retention periods
- Even the root user cannot delete backups when enable
## Transferring large amount of data into AWS
- Example: transfer 200TB of data in the cloud. We have a 100 Mbps internet connection.
- Over the internet / Site-to-Site VPN:
    - Immediate to Setup
    - Will take 200(TB) * 1000(GB) * 1000(MB) * 8(MB)/100 MBps = 16000000s = 185d
- Over direct connect 1Gbps:
    - Log for the one time setup (over a month)
    - Will take 200(TB) * 1000(GB) * 8(GB) / 1 Gbps = 18.5d
- Over Snowball:
    - Will take 2 to 3 snowballs i parallel
    - Takes about 1 week for the end-to-end transfer
    - Ca be combined with DMS
- For ongoing replication / transfer: Site - to - Site VP or DX with DMS or DataSync
