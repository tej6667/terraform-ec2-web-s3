###############################################################
# VPC, Subnets, Internet Gateway, and Route Table Resources
#
# This Terraform configuration creates the following AWS resources:
#
# 1. VPC:
#    - A Virtual Private Cloud (VPC) with a /16 CIDR block.
#    - DNS support and DNS hostnames are enabled.
#
# 2. Public Subnets:
#    - Three public subnets, each in a different Availability Zone.
#    - Each subnet has a /24 CIDR block and auto-assigns public IPs.
#
# 3. Private Subnets:
#    - Three private subnets, each in a different Availability Zone.
#    - Each subnet has a /24 CIDR block.
#    - Note: 'map_public_ip_on_launch' is set to true, which is unusual for private subnets.
#
# 4. Internet Gateway:
#    - An Internet Gateway attached to the VPC for internet access.
#
# 5. Public Route Table:
#    - A route table with a default route (0.0.0.0/0) pointing to the Internet Gateway.
#    - Associated with all three public subnets.
#
# 6. Route Table Associations:
#    - Each public subnet is associated with the public route table to enable internet access.
#
# Variables:
#    - 'var.zone1', 'var.zone2', 'var.zone3' specify the Availability Zones for subnets.
#
# Tags:
#    - All resources are tagged for identification.
#
# Note:
#    - Private subnets typically do not have 'map_public_ip_on_launch' enabled.
#      Consider setting this to 'false' for private subnets if public IPs are not required.
###############################################################
# Create a VPC with DNS support and hostnames enabled
resource "aws_vpc" "Terraform_VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Terraform_VPC"
  }
}

# Public Subnet 1 in Availability Zone 1
resource "aws_subnet" "Terraform_VPC-pub-1" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1
  tags = {
    Name = "Terraform_VPC-pub-1"
  }
}

# Public Subnet 2 in Availability Zone 2
resource "aws_subnet" "Terraform_VPC-pub-2" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2
  tags = {
    Name = "Terraform_VPC-pub-2"
  }
}

# Public Subnet 3 in Availability Zone 3
resource "aws_subnet" "Terraform_VPC-pub-3" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone3
  tags = {
    Name = "Terraform_VPC-pub-3"
  }
}

# Private Subnet 1 in Availability Zone 1
resource "aws_subnet" "Terraform_VPC-priv-1" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1
  tags = {
    Name = "Terraform_VPC-priv-1"
  }
}

# Private Subnet 2 in Availability Zone 2
resource "aws_subnet" "Terraform_VPC-priv-2" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2
  tags = {
    Name = "Terraform_VPC-priv-2"
  }
}

# Private Subnet 3 in Availability Zone 3
resource "aws_subnet" "Terraform_VPC-priv-3" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone3
  tags = {
    Name = "Terraform_VPC-priv-3"
  }
}

# Internet Gateway for the VPC
resource "aws_internet_gateway" "Terraform_VPC-IGW" {
  vpc_id = aws_vpc.Terraform_VPC.id
  tags = {
    Name = "Terraform_VPC-IGW"
  }
}

# Public Route Table with route to Internet Gateway
resource "aws_route_table" "Terraform_VPC-pub-RT" {
  vpc_id = aws_vpc.Terraform_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terraform_VPC-IGW.id
  }

  tags = {
    Name = "Terraform_VPC-pub-RT"
  }
}

# Associate Public Subnet 1 with the Public Route Table
resource "aws_route_table_association" "Terraform_VPC-pub-1-a" {
  subnet_id      = aws_subnet.Terraform_VPC-pub-1.id
  route_table_id = aws_route_table.Terraform_VPC-pub-RT.id
}

# Associate Public Subnet 2 with the Public Route Table
resource "aws_route_table_association" "Terraform_VPC-pub-2-a" {
  subnet_id      = aws_subnet.Terraform_VPC-pub-2.id
  route_table_id = aws_route_table.Terraform_VPC-pub-RT.id
}

# Associate Public Subnet 3 with the Public Route Table
resource "aws_route_table_association" "Terraform_VPC-pub-3-a" {
  subnet_id      = aws_subnet.Terraform_VPC-pub-3.id
  route_table_id = aws_route_table.Terraform_VPC-pub-RT.id
}
