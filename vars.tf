# This file defines variables used throughout the Terraform configuration.

# AWS region where resources will be created.
variable "region" {
  default = "us-east-2" # Default AWS region
}

# AWS availability zone within the region.
variable "zone1" {
  default = "us-east-2a" # Default availability zone
}
variable "zone2" {
  default = "us-east-2b" # Default availability zone
}
variable "zone3" {
  default = "us-east-2c" # Default availability zone
}
variable "webuser" {
  default = "ubuntu" # Default user
}

# Map of AMI IDs for different AWS regions.
# Update these values to match the AMI you want to use in your chosen region.
variable "amiID" {
  type = map(any)
  default = {
    us-east-1 = "ami-0731becbf832f281e" # Example AMI ID for Ubuntu 24.04 LTS (Jammy Jellyfish)
    us-east-2 = "ami-004364947f82c87a0" # Example AMI ID for Ubuntu 24.04 LTS (Jammy Jellyfish)
  }
}