# terraform-ec2-web-s3

A beginner-friendly Terraform project to create and provision a basic EC2 instance in AWS, with remote state management and web server setup.

## What is this project?

This project helps you automatically create an EC2 (virtual machine) instance in AWS using Terraform. It also sets up a security group, SSH key pair, and provisions the instance as a web server. The Terraform state is stored remotely in an S3 bucket for better collaboration and safety. Instead of clicking through the AWS console, you can use this code to create your infrastructure consistently and reproducibly.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed - The tool that will create our infrastructure
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured (`aws configure`) - Allows Terraform to communicate with AWS
- An AWS account with permissions to create EC2 instances and S3 buckets

## Project Components

This project creates:
- An EC2 instance (virtual machine)
- A security group (firewall rules)
- An SSH key pair for secure access
- A web server (Apache) with a sample website
- Remote Terraform state storage in an S3 bucket

## File Descriptions

- **Provider.tf**: Configures the AWS provider and region.
- **vpc.tf**: Defines the Virtual Private Cloud (VPC) and related networking resources such as subnets, internet gateway, and route tables.
- **Instance.tf**: Defines the EC2 instance, including AMI, instance type, key pair, and user data for provisioning the web server.
- **KeyPair.tf**: Manages the SSH key pair used to access the EC2 instance.
- **SecurityGroup.tf**: Sets up firewall rules to allow SSH (port 22) and HTTP (port 80) access.
- **vars.tf**: Contains variable definitions for customizing region, instance type, AMI, etc.
- **backend.tf**: Configures remote state storage in an S3 bucket, so your Terraform state file is stored securely and can be shared across your team.
- **web.sh**: A shell script run on the EC2 instance at launch. It installs Apache, downloads a website template, and deploys it to `/var/www/html/`.
- **instID.tf**: Outputs the EC2 instance ID after creation.
- **.gitignore**: Ensures sensitive files (like private keys and state files) are not committed to version control.
- **terraform.tfstate / terraform.tfstate.backup**: Tracks the current state of your infrastructure (do not edit manually).
- **tf_key / tf_key.pub**: The private and public SSH keys generated for EC2 access (should be kept secure).

## Quick Start

```bash
# Clone the repository to your local machine
git clone https://github.com/your-username/terraform-ec2-web-s3.git
cd terraform-ec2-web-s3

# Download required Terraform providers and modules
terraform init

# See what resources will be created (like a dry run)
terraform plan

# Create the resources in AWS
terraform apply
# Type 'yes' when prompted to confirm

# When you're finished, remove all created resources
# IMPORTANT: This will delete everything this project created
terraform destroy
# Type 'yes' when prompted to confirm
```

## Important Notes

- After running `terraform apply`, you'll see output with information about your new EC2 instance.
- Resources created by this project may incur AWS charges.
- Always remember to run `terraform destroy` when you're done to avoid unnecessary costs.
- Before running, update the following:
  - AWS region: `Provider.tf`
  - Instance type: `Instance.tf` or `vars.tf`
  - IP in Security Group: `SecurityGroup.tf`
  - Key pair: `KeyPair.tf`
  - Variables: `vars.tf`
  - S3 bucket details for remote state: `backend.tf`

## Troubleshooting

Common issues:
1. "AWS credentials not found" - Run `aws configure` to set up your AWS credentials.
2. "Permission denied" - Ensure your AWS user has appropriate permissions.
3. "Resource already exists" - Make sure you're not trying to create resources that already exist.
4. "S3 bucket not found" - Make sure the S3 bucket for remote state exists and is accessible.

## Security Best Practices

- Never commit AWS credentials to version control.
- Review security group rules before applying.
- Keep your SSH private key secure.

## Need Help?

- Check [Terraform documentation](https://www.terraform.io/docs)
- Visit [AWS documentation](https://docs.aws.amazon.com)
- Review the code comments in the .tf files for detailed explanations



