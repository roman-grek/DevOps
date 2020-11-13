provider "aws" {
    shared_credentials_file = "/home/roman/.aws/credentials"
    profile                 = "default"
    region                  = "us-east-1"
}

resource "aws_vpc" "My_VPC" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = false

    tags = {
        Name = "My VPC"
    }
}

resource "aws_subnet" "Public_Subnet_A" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = "10.0.10.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1a"
    tags = {
        Name = "Public-Subnet-A"
    }
}

resource "aws_subnet" "Public_Subnet_B" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = "10.0.20.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1b"
    tags = {
        Name = "Public-Subnet-B"
    }
}

resource "aws_subnet" "Private_Subnet" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = "10.0.11.0/24"
    map_public_ip_on_launch = false
    availability_zone       = "us-east-1a"
    tags = {
        Name = "Private-Subnet"
    }
}

resource "aws_security_group" "my-web-sg" {
    vpc_id       = aws_vpc.My_VPC.id
    name         = "my-web-sg"
    description  = "My VPC Security Group"
  
    # allow ingress of port 22
    ingress {
        cidr_blocks = ["178.127.99.207/32"]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    } 

    # allow ingress of port 80
    ingress {
        cidr_blocks = ["10.0.0.0/16"]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
    } 
  
    # allow egress of all ports
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "my-web-sg"
    }
}

resource "aws_network_acl" "My_Public_ACL" {
    vpc_id = aws_vpc.My_VPC.id
    subnet_ids = [ aws_subnet.Public_Subnet_A.id, aws_subnet.Public_Subnet_B.id ]

    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }
  
    egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = "My Public ACL"
    }
}

resource "aws_network_acl" "My_Private_ACL" {
    vpc_id = aws_vpc.My_VPC.id
    subnet_ids = [ aws_subnet.Private_Subnet.id ]

    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "10.0.0.0/16"
        from_port  = 0
        to_port    = 0
    }
  
    egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = "My Private ACL"
    }
}

resource "aws_internet_gateway" "My_VPC_GW" {
    vpc_id = aws_vpc.My_VPC.id

    tags = {
        Name = "My VPC Internet Gateway"
    }
}

resource "aws_route_table" "My_Public_RT" {
    vpc_id = aws_vpc.My_VPC.id
    tags = {
        Name = "My Public Route Table"
    }
}

resource "aws_route_table" "My_Private_RT" {
    vpc_id = aws_vpc.My_VPC.id
    tags = {
        Name = "My Private Route Table"
    }
}

resource "aws_route" "My_VPC_internet_access" {
    route_table_id         = aws_route_table.My_Public_RT.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.My_VPC_GW.id
}

resource "aws_route_table_association" "My_Public_association_A" {
    subnet_id      = aws_subnet.Public_Subnet_A.id
    route_table_id = aws_route_table.My_Public_RT.id
}

resource "aws_route_table_association" "My_Public_association_B" {
    subnet_id      = aws_subnet.Public_Subnet_B.id
    route_table_id = aws_route_table.My_Public_RT.id
}

resource "aws_route_table_association" "My_Private_association" {
    subnet_id      = aws_subnet.Private_Subnet.id
    route_table_id = aws_route_table.My_Private_RT.id
}