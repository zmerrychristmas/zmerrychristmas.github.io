---
title: AWS Virtual Private Cloud Overview (VPC) part 1
tags:
- AWS
- VPC
- NACL
- Transit Gateway
- AWS Private Link
- Direct Connect
- VPC Flow Logs
- Ephemeral Ports
- VPC Peering
- Internet Gateway
- NAT
- AWS VPN CloudHub
- VPN
categories:
- Fullstack
- Blogging
- AWS
---

# Virtual Private Cloud (VPC)
## Default VPC Walkthrough
- All new AWS accounts have a default VPC
- New EC2 instances are launched into the default VPC of no subnet is specified
- Default VPC has Internet connectivity and all EC2 instances inside it have public IPv4 addresses
- We also get a public and a private IPv4 DNS names
## VPC in AWS - IPv4
- VPC = Virtual Private Cloud
- You can have multiple VPCs in an AWS region (max. 5 per region - soft limit)
- Max. CIDR per VPC is 5, for each CIDR
    - Min. size is /28 (16 addresses)
    - Max. size is /16 (65536 IP addresses)
- Because VPC is private, only the Private IPv4 tanges are allowed
    - 10.0.0.0 – 10.255.255.255 (10.0.0.0/8)
    - 172.16.0.0 – 172.31.255.255 (172.16.0.0/12)
    - 192.168.0.0 – 192.168.255.255 (192.168.0.0/16)
- Your VPC CIDR should NOT overlap with your other networks (e.g corporate)
## VPC – Subnet (IPv4)
- AWS reserves 5 IP addresses (first 4 & last 1) in each subnet
- These 5 IP addresses are not available for use and can't be assigned to an EC2 instance
- Example; if CIDR block 10.0.0.0/24 then reserved IP addresses are:
    - 10.0.0.0 - Network Address
    - 10.0.0.1 - reserved by AWS for the VPC router
    - 10.0.0.2 - reserved by AWS for mapping to mazon-provided DNS
    - 10.0.0.3 - reserved by AWS for future use
    - 10.0.0.255 - Network Broadcast Addressm AWS does not support broadcast in a VPC therefore the address is reserved
- Exam tip:  if you need 29 IP addresses for EC2 instances:
    - You can't choose a subnet of size /27 (32 IP addresses, 32-5 = 27 < 29)
    - you need to choose a subnet of size /26 (64 IP address, 64 - 5 = 59 > 29)
## Internet Gateway (IGW)
- Allows resources (e.g EC2 instances) in a VPC connect to the Internet
- It scales horizontally and is highly available and redudant
- Must be created separately from a VPC
- One VPC can only be attached to one IGW and vice versa
- Internet Gateways on their own do not allow Internet access...
- Route tables must also be edited!
## State of Hands-on
## Adding Subnets
## Adding Internet Gateway
## Editing Route Tables
![](https://data.terabox.com/thumbnail/9fb62f1596e9ed4dc2fc7fefd6d03f32?fid=4401547290288-250528-267962913534974&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-4wpRmb5WiiClJEKWWac4tUx2jiQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=282799347026048208&dp-callid=0&time=1667786400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Bastion Hosts
- We can use a **Bastion Host to SSH** into our private EC2 instances
- The bastion is in the public subnet which is then connected to all other private subnets
- Basion Host security group must be tighened
- Exam Tip: Makesure the bastion host only has port 22 traffic from the IP address you need not from the security groups of your other EC2 instances
![](https://data.terabox.com/thumbnail/3cd2fd8a8573a1b98e48f214f0abc928?fid=4401547290288-250528-138276258724815&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-bjiEXYU1AD6mmSyDTPWdYPHBIzw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=282846205064584510&dp-callid=0&time=1667786400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NAT Instance (outdated, but still at the exam)
- NAT = Network Address Translation
- **Allows EC2 instances in private subnet to connect to the Internet**
- Must be launched in a public subnet
- Must disable EC2 setting: Source / destination Check
- Must have **Elastic IP** attached to it
- Route Tables must be configured to route traffic from private subnets to the NAT instance
![](https://data.terabox.com/thumbnail/2a47b3cbc0164e6945f11e6243385c2a?fid=4401547290288-250528-992807556060211&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-%2bsDYOmzvE6jB2DfTtTq%2bd8cqQjY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=282899231088131500&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NAT Instance
![](https://data.terabox.com/thumbnail/9d130b0e5c42d1dee1983d51aec13d92?fid=4401547290288-250528-477603417274662&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-LB2%2f3mHMFxnxsrt6%2foQOz0qZ1%2fM%3d&expires=8h&chkbd=0&chkv=0&dp-logid=282930543950583860&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NAT Instance – Comments
- Pre-configured Amazon Linux AMI is available
    - Reached the end of standard support on December 31, 2020
- Not highly available / **resilient** setup out of the box
    - You need to create an **ASG** in multi-AZ + resilient user-data script
- Internet traffic bandwidth depends on EC2 instance type
- You must manage Security Groups & Rules:
    - Inbound:
        - Allow *HTTP / HTTPS* traffic coming from Private Subnets
        - Allow *SSH* from your **home network** (access is provided through Internet Gateway)
    - Outbound:
        - Allow **HTTP / HTTPS** traffic to the Internet
## NAT Gateway
- AWS-managed NAT, higher bandwidth, high availability, no administration
- **Pay per hour** for usage and bandwidth
- NATGW is created in a specific Availability Zone, uses an Elastic IP
- Can’t be used by EC2 instance in the same subnet (only from other subnets)
- Requires an **IGW** (Private Subnet => NATGW => IGW)
- 5 Gbps of bandwidth with automatic scaling up to 45 Gbps
- No Security Groups to manage / required
![](https://data.terabox.com/thumbnail/823c0bf01053475124de6af869831d84?fid=4401547290288-250528-17275655260103&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-74CSI7l9idweuR%2fA43e1pCmHNHc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283163126554811121&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NAT Gateway with High Availability
- NAT Gateway is resilient within a single Availability Zone
- Must create multiple NAT Gateways in multiple AZs for fault-teolerance
- There is no cross-AZ failover needed because if an AZ goes down it doesn't need NAT
![](https://data.terabox.com/thumbnail/70dd59287aa21bb7dfb8805327db6888?fid=4401547290288-250528-276097707808678&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Ipk4hMI0JTUVmPuudtNmH454dls%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283234449625563540&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NAT Gateway vs. NAT Instance
![](https://data.terabox.com/thumbnail/656b0c4bb192c37c2ec5e1f4b0d9a408?fid=4401547290288-250528-50458833276319&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-NPu6m4bd9tj0eS54629%2bueSfwII%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283259238658395034&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DNS Resolution in VPC
- DNS Resolution (enableDnsSupport)
    - Decides if DNS resolution from Route 53 Resolver server is supported for the VPC
    - True (default): it queries the Amazon Provider DNS Server at 169.254.169.253 or the reserved IP address at the base of the VPC Ipv4 network range plus two
![](https://data.terabox.com/thumbnail/9ed3ff1f8756a32d2e2cfb63061bb4eb?fid=4401547290288-250528-1009614502455797&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EbMYG0dsg3UDF%2b%2fU8lmoieXd%2bpw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283697272948062055&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DNS Resolution in VPC
- DNS Hostnames (**enableDnsHostnames**)
    - By default
        - True => default VPC
        - False => newly created VPCs
    - Won’t do anything unless enableDnsSupport=true
    - If True, assigns public hostname to EC2 instance if it has a public IPv4
![](https://data.terabox.com/thumbnail/a3a68fd61b3a887dc62b25e79d6a9d12?fid=4401547290288-250528-570743489931740&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-zkuc8UTTig4z0t4e9DuGV89f8oI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283736114576449515&dp-callid=0&time=1667790000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## DNS Resolution in VPC
- If you use custom DNS domain names in a Private Hosted Zone in Route 53, you must set both these attributes (enableDnsSupport & enableDnsHostname) to true
![](https://data.terabox.com/thumbnail/16bb289879e42b7553577efd09c1b903?fid=4401547290288-250528-986092333977002&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-2R151TZsc6%2bheEjyy%2byyVKcIrVk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283859264380443457&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Security Groups & NACLs
### Incoming Request
![](https://data.terabox.com/thumbnail/785a88a7064ba6bb2a5c7ba66def50f9?fid=4401547290288-250528-195470369874452&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-gOR6%2f0hrjDWBKbEUmC0P%2bbw2zv0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283899014333498181&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
### Outgoing Request
![](https://data.terabox.com/thumbnail/9f7acdce107e635c698de1e35f40a509?fid=4401547290288-250528-358988252706630&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-MvXgrPGpa9L6bl3ts4S2qhc9lxg%3d&expires=8h&chkbd=0&chkv=0&dp-logid=283917836417513624&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Network Access Control List (NACL)
- NACL are like a firewall which control traffic from and to subnet
- One NACL per subnet, new subnets are assigned the Default NACL
- You define NACL Rules:
    - Rules have a number (1-32766), higher precedence with a lower number
    - First rule match will drive the decision
    - Example: if you define #100 ALLOW 10.0.0.10/32 and #200 DENY 10.0.0.10/32, the IP address will be allowed because 100 has a higher precedence over 200
    - The last rule is an asterisk (\*) and denies a request in case of no rule match
    - AWS recommends adding rules by increment of 100
- Newly created NACLs will deny everything
- NACL are a great way of blocking a specific IP address at the subnet level
## NACLs
![](https://data.terabox.com/thumbnail/4a8763fb6439eb2a4d8d2a1d8548a85c?fid=4401547290288-250528-602714999390062&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-uUHsNau0ehOD9cJvWbWPTAGNiaQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284030649146595937&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- default NACLs
    - Accepts everything inbound/outbound with the subnets it’s associated with
    - Do NOT modify the Default NACL, instead create custom NACLs
![](https://data.terabox.com/thumbnail/8079963019e0e4a8f3ccda1ecd589685?fid=4401547290288-250528-198544445042386&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-9OBw%2fkfIi8O7rvIhb8EYs2wqmWk%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284081867571416673&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Ephemeral Ports
- For any two endpoints to establish a connection, they must use ports
- Clients connect to a defined port, and expect a response on an ephemeral port
- Different Operating Systems use different port ranges, examples:
    - IANA & MS Windows 10 -> 49152 - 65535
    - Many Linux Kernels -> 32768 - 60999
![](https://data.terabox.com/thumbnail/bf6db854885e7ecc341d59e1f1d831fe?fid=4401547290288-250528-1017307392113384&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BOsDYjYjOzyh%2bAYPdmMBg2rjWwQ%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284155829562810696&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## NACL with Ephemeral Ports
![](https://data.terabox.com/thumbnail/a684f552865130bdfd324e5fd6d5b3f8?fid=4401547290288-250528-266773662537168&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-EylWuZC01yHD4li7PdODPiFpiUg%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284181500025740932&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Create NACL rules for each target subnets CIDR
![](https://data.terabox.com/thumbnail/5e6814c32300ccaf1e84bdfffdcf757d?fid=4401547290288-250528-446865333136786&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-yskDvGsIbINSx88EqVj%2bOHfDLw0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284296033448281598&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Security Group vs. NACLs
![](https://data.terabox.com/thumbnail/20a12ef137884ef313875ee5795c610f?fid=4401547290288-250528-215891567433945&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-cIe7%2ffBQpnB6C3xUpbxZA%2bl1TVw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284342840648945730&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC – Reachability Analyzer
- **A network diagnostics tool** that troubleshoots network connectivity between two endpoints in your VPC(s)
- It builds a model of the network configuration, then checks the reachability based on these configurations (it doesn't send packets)
- When the destination is
    - Reachable - It proceduces hop by hop details of the virtual network path
    - Not reachable - It identifies the blocking components
- Use cases: troubleshoot connectivity issues, ensure network configuration is as intended...
![](https://data.terabox.com/thumbnail/3934e36b9b6960f639760df6bfd046b3?fid=4401547290288-250528-288814259442807&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-ki9rYjz3XvOpUCgjAssoKZq21k4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284502339218381820&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Peering
- Privately connect two VPCs using AWS network
- Make them behave as if they were in the same network
- Must not have overlapping CIDRs
- VPC Peering connection is NOT transitive (must be established for each VPC that need to communicate with one another)
- You must update route tables in each VPC's subnets to ensure EC2 instances can communicate with each other
![](https://data.terabox.com/thumbnail/1b07a43aa0bf042e75f1ca524f7eb2df?fid=4401547290288-250528-757932012546600&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-J1ZequbycllRe0M0VNfHC92Rghc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=284559647513922897&dp-callid=0&time=1667793600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Peering – Good to know
- You can create VPC Peering connection between VPCs in different AWS accounts/regions
- You can reference a security group in a peered VPC (works cross – same region)
![](https://data.terabox.com/thumbnail/642836c478a88d3eb63a8b8c3d222c55?fid=4401547290288-250528-200380958320443&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-5Fzc1KHjTZ8hO3jBMlrHcpuR3tA%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286179420412954340&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Peering
![](https://data.terabox.com/thumbnail/91a75cb525126c2077a94101cbcd1f10?fid=4401547290288-250528-104339546682393&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-J5XOK49QaYoimRvFRF0dtLv5yp8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286200908082051641&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Endpoints
![](https://data.terabox.com/thumbnail/99dac4a7aced51e43b1330cb6f8d10b0?fid=4401547290288-250528-1042791383192014&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Zmv64lxOhMurl1u%2fmXFxPu0q0bI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286372589493266339&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Endpoints (AWS PrivateLink)
- Every AWS service is publicly exposed (public URL)
- VPC Endpoints (powered by AWS PrivateLink) allows you to connect to AWS services using a private network instead of using the public Internet
- They're redudant and scale horizontally
- They remove the need of IGW, NATGW,... to access AWS Services
- In case of issues
    - Check DNS Setting Resolution in your VPC
    - Check Route Tables
![](https://data.terabox.com/thumbnail/6c502b46d55a17f5e4a86750854d7bf7?fid=4401547290288-250528-714661903672576&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-IxhZ3uYNO0oIVmbx8FIj6U2hDqc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286511696333427470&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Types of Endpoints
- Interface Endpoints
    - Provisions an ENI (private IP address) as an entry point (must attach a Security Group)
    - Supports most AWS services
- Gateway endpoints
    - Provisions a gateway and must be used as a target in a route table
    - Supports both S3 and DynamoDB
## VPC Flow Logs
- Capture information about IP traffic going into your interfaces:
    - VPC Flow Logs
    - Subnet Flow Logs
    - Elastic Network Interface (ENI) FLow Logs
- Helps To monitor & troubleshoot connectivity issues
- Flow logs data can go to S3 / CLoudWatch Logs
- Captures network information from AWS managed interfaces too: ELB, RDS, ElastiCache, Redshift, Workspaces, NATGW, Transit Gateway...
## VPC Flow Logs
![](https://data.terabox.com/thumbnail/4b028f9de2ce9b4818afbae77303f60e?fid=4401547290288-250528-792214063705990&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-X7hsVq5drjKnS6MgEMPHSvwCkDc%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286663488675861018&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## VPC Flow Logs Syntax
![](https://data.terabox.com/thumbnail/6d8e611a920154fc11dddbe46fd105df?fid=4401547290288-250528-1018178524076876&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-p5gqnFvF%2bDDpdW1laGe5ZHYHB44%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286730840888121535&dp-callid=0&time=1667800800&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- srcaddr & dstaddr: help identify problematic IP
- srcport & dstport: help identify problematic ports
- Action: success or failure of the request due to security group / NACL
- Can be used for analytics on usage patterns, or malicious behavior
- Query VPC flow logs using Athena on S3 or CloudWatch Logs Insights
- Flow Logs examples: https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-records-examples.html
## VPC Flow Logs – Troubleshoot SG & NACL issues
- Incoming Requests
    - Inbound REJECT => NACL or SG
    - Inbound ACCEPT, Outbound REJECT => NACL
- Outgoing Requests
    - Outbound REJECT => NACL or SG
    - Outbound ACCEPT, Inbound REJECT => NACL
![](https://data.terabox.com/thumbnail/8e5f500ef0bf9a3cd692ba072d3137fb?fid=4401547290288-250528-225077615269248&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-QlAN1qrn7LBoR658ylUoYO7B1ok%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286805394433838249&dp-callid=0&time=1667804400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Site-to-Site VPN
![](https://data.terabox.com/thumbnail/91c2faff8a3b1115541754f96205b753?fid=4401547290288-250528-356904733988475&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-bFEZe7mVxXZg%2fGqaGD%2f8lTNdARg%3d&expires=8h&chkbd=0&chkv=0&dp-logid=286908133371043706&dp-callid=0&time=1667804400&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Site-to-Site VPN
- Virtual Private Gateway (VGW)
    - VPN concentrator on the AWS side of the **VPN connection**
    - VGW is created and attached to the VPC from which you want to create the Site-to-site VPN connection
    - Possibility to customize the ASN (Autonomous System Number)
- Customer Gateway (CGW)
    - Software application or physical device on customer side of the VPN connection
    - https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html
## Site-to-site VPN connections
- Customer Gateway Device (On-premises)
    - What IP address to use?
        - **Public** Internet routable IP address for your customer gateway device
        - If it's behind a NAt device that's enabled for **NAT traversal** (NAT-T), use the public IP address of the NAT device
- **Important step**: enable **Route Propagation** for the virtual private gateway in the route table that is associated with your subnets
- If you need to ping your EC2 instances from on-premise, make sure you ad the ICMP protocol on the inbound of your security groups
![](https://data.terabox.com/thumbnail/94373c9b4110180083a185ed7b5a2d75?fid=4401547290288-250528-422579053415839&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-gqfky3e%2fLR9ZoDXcPQHe7BXXSik%3d&expires=8h&chkbd=0&chkv=0&dp-logid=287893691826151050&dp-callid=0&time=1667808000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS VPN CloudHub
- Provide secure communication between multiple sites, if you have multiple VPN connections
- Low cost hub and spoke model for primary or secondary network connectivity between diffrent locations (VPN only)
- It's a VPN connection so it goes over the public internet
- To set it up, connect multiple VPN connections on the sam VGW, setup dynamic routing and configure route tables
![](https://data.terabox.com/thumbnail/5ae149b1e0d401daa96ab2bce8fe81f8?fid=4401547290288-250528-969713016236289&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-VKldoj3o12T1VMe97ryBEZQ8MiI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=288292760496408384&dp-callid=0&time=1667808000&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Direct Connect (DX)
- Provides a **dedicated private connection** from a remote network to your VPC
- Dedicated connection must be setup between your DC and AWS Direct Connect locations
- You need to setup a Virtual Private Gateway on your VPC
- Access Public resources (S3) and private (EC2) on same connection
- Use Cases:
    - Increase bandwidth thoughtput - working with large data sets - lower cost
    - More consistent network experience - application using real-time data feeds
    - Hybrid environments (on-prem + cloud)
- Supports both IPv4 and IPv6
## Direct Connect Diagram
![](https://data.terabox.com/thumbnail/58350f1ff40d11a2c73b2c1fe1e7d220?fid=4401547290288-250528-344265522118998&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-0UPhqFKXAL0Y9zX9ReFtwkaLyOE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289177467370571966&dp-callid=0&time=1667811600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Direct Connect Gateway
- If you want to setup a Direct Connect to one or more VPC in many different regions (same account), you must use a Direct Connect Gateway
![](https://data.terabox.com/thumbnail/25f6b0c1fadb66040bf22b534d294907?fid=4401547290288-250528-376930071057630&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Y9LzTcgmHLu3dXtT71Uq9YbnJfY%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289254210436593044&dp-callid=0&time=1667811600&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Direct Connect – Connection Types
- Dedicated Connections: 1Gbps and 10 Gps capacity
    - Physical ethernet port dedicated to a customer
    - Request made to AWS first, then completed by AWS Direct Connect Partners
- Hosted Connection: 50Mbs, 500 Mbps, to 10 Gbps
- Connection requests are made via AWS Direct Connect Partners
- Capacity can be added or removed on demand
- 1, , 5, 10 Gbps available at select AWS Direct Connect Partners
- Lead times are often longer than 1 month to establish a new connection
## Direct Connect – Encryption
- Data in transit is not encrypted but is private
- AWS Direct Connect + VPN provides an IPsec-encrypted private connection
- Good for an extra level of security, but slightly more complex to put in place
![](https://data.terabox.com/thumbnail/4b37b0d874e5a9baa6089f6f306f2bf7?fid=4401547290288-250528-922957861536436&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-zFoJg1Z8L1goubMxuwNBjSKuPP4%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289647769806591335&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Direct Connect - Resiliency
- High Resiliency for Critical Workloads
![](https://data.terabox.com/thumbnail/9ebc74712abfc78336b3dcc5daddee90?fid=4401547290288-250528-732693425135076&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Sb4BjMOyAGzu9rYVtRLwcRHWP1k%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289658859510790275&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
- Maximum Resiliency for Critical Workloads
![](https://data.terabox.com/thumbnail/0ff6f5ca101713ad4f085f178238fc09?fid=4401547290288-250528-590578672481082&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-WPDoMuFHVZbv99mWE0eIDUExeHo%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289665808302865451&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Exposing services in your VPC to other VPC
- Option 1: make it public
    - Goes through the public www
    - Tough to manage access
- Option 2: VPC peering
    - Must create many perring relations
    - Open the whole network
![](https://data.terabox.com/thumbnail/2e3f611cf5d0862e29b00098bd1e4abb?fid=4401547290288-250528-604279332886054&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-PAqCaq%2fKpyHXLSniCEEQPzECY8A%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289701508352776293&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS PrivateLink (VPC Endpoint Services)
- Most secure & scalable way to expose a service to 1000s of VPC (own or other accounts)
- Does not require VPC peering, internet gateway, NAT, route tables...
- Requires a network load balancer (Service VPC) and ENI (Customer VPC) or GWLB
- If the NLB is in multiple AZ, and the ENIs in multiple AZ, the solution is fault tolerant!
![](https://data.terabox.com/thumbnail/6b56c5a7373cdbb703a37caa1888da5d?fid=4401547290288-250528-784347349490601&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-nz8x0%2fam3xpJDdBdWxJRe%2bKehY0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289750424838492290&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## AWS Private Link & ECS
![](https://data.terabox.com/thumbnail/b2907eef3ee81cbbe562b757eebb0e93?fid=4401547290288-250528-965122680161330&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BPxiLUFO4YppgD4SGGQ9x7Fgd1I%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289771978701280078&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## EC2-Classic & AWS ClassicLink (deprecated)
- EC2-Classic: instances run in a single network shared with other customers
- AmazonVPC: your instances run logically isolated to your AWS account
- ClassicLink allows you to link EC2-Classic instances to a VPC in your account
    - Must associate a security group
    - ENables communication using privte Upv3 addressess
    - Removes the need to make use of public IPv4 addressess or Elastic IP addresses
- Likely to be distractors at the exam
## Network topologies can become complicated
![](https://data.terabox.com/thumbnail/49eea187ad7739d3b312f702ded8668a?fid=4401547290288-250528-63180888063251&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-wr8clngd7kKiXqX7fo9Wxczo1Uw%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289855404093542558&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Transit Gateway
- For having transitive peering between **thousands** of VPC and on-premise, hub and spoke **(star) connection**
- Regional resource, can work cross region
- Share cross-account using Resource Access Manager (RAM)
- You can peer **Transit Gateway** across regions
- Route Tables: limit which VPC can talk with other VPC
- Works with ** Direct Connect Gateway, VPn connections**
- Supports **Ip Multicast** (not suppoerted by any other AWS service)
![](https://data.terabox.com/thumbnail/d551df493d8b171c13d926d072e873db?fid=4401547290288-250528-193820090315068&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-BkgkYsENcOMODxD9zzEhrTdSBH8%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289907492255367657&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Transit Gateway: Site-to-Site VPN ECMP
- ECMP = Equal - cost multi path routing
- Routing strategy to allow to forward a packet over multiple best path
- Use case: create multiple Site to site VPN connections to increase the bandwidth of your connection to AWS
![](https://data.terabox.com/thumbnail/a86d56ac578d8ac3128f5a81d20cde3e?fid=4401547290288-250528-413675193681665&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-lvnRPyOF%2fyzRj%2f%2femlXsYbkoIHE%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289962096922569176&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Transit Gateway: throughput with ECMP
![](https://data.terabox.com/thumbnail/bb54da9db2e41de0ad4fe363dd70b5c8?fid=4401547290288-250528-1123455717811634&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-1GsbLtaYahwpRnlJQKD8wNR57BI%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289980080171961953&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
![](https://data.terabox.com/thumbnail/079318e194a8d85aa29f2eed1ff61dec?fid=4401547290288-250528-1023861835273441&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-f0HVYgg%2fXFuRx8Hb3%2foJh8T3C1w%3d&expires=8h&chkbd=0&chkv=0&dp-logid=289980080171961953&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
## Transit Gateway – Share Direct Connect between multiple accounts
![](https://data.terabox.com/thumbnail/0b3493220cc63dabb9c199e2ed81b80e?fid=4401547290288-250528-401096758763359&rt=pr&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-x%2bY4RgirSfJ%2fXTG5UgQhDWUqRn0%3d&expires=8h&chkbd=0&chkv=0&dp-logid=290014867337055451&dp-callid=0&time=1667815200&size=c1920_u1080&quality=90&vuk=4401547290288&ft=image&autopolicy=1)
