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
  availability_zone       = vars.zone1
  tags = {
    Name = "Terraform_VPC-pub-1"
  }
}

# Public Subnet 2 in Availability Zone 2
resource "aws_subnet" "Terraform_VPC-pub-2" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = vars.zone2
  tags = {
    Name = "Terraform_VPC-pub-2"
  }
}

# Public Subnet 3 in Availability Zone 3
resource "aws_subnet" "Terraform_VPC-pub-3" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = vars.zone3
  tags = {
    Name = "Terraform_VPC-pub-3"
  }
}

# Private Subnet 1 in Availability Zone 1
resource "aws_subnet" "Terraform_VPC-priv-1" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = vars.zone1
  tags = {
    Name = "Terraform_VPC-priv-1"
  }
}

# Private Subnet 2 in Availability Zone 2
resource "aws_subnet" "Terraform_VPC-priv-2" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = vars.zone2
  tags = {
    Name = "Terraform_VPC-priv-2"
  }
}

# Private Subnet 3 in Availability Zone 3
resource "aws_subnet" "Terraform_VPC-priv-3" {
  vpc_id                  = aws_vpc.Terraform_VPC.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = vars.zone3
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
