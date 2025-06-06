# terraform-ec2-basic-setup

A beginner-friendly Terraform project to create a basic EC2 instance in AWS.

## What is this project?

This project helps you automatically create an EC2 (virtual machine) instance in AWS using Terraform. Instead of clicking through the AWS console, you can use this code to create your infrastructure consistently and reproducibly.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed - The tool that will create our infrastructure
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured (`aws configure`) - Allows Terraform to communicate with AWS
- An AWS account with permissions to create EC2 instances - Where our resources will be created

## Project Components

This project creates:
- An EC2 instance
- A security group (firewall rules)
- An SSH key pair for secure access

## Quick Start

```bash
# Clone the repository to your local machine
git clone https://github.com/your-username/terraform-ec2-setup.git
cd terraform-ec2-setup

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

- After running `terraform apply`, you'll see output with information about your new EC2 instance
- Resources created by this project may incur AWS charges
- Always remember to run `terraform destroy` when you're done to avoid unnecessary costs

Before running, update the following :
- AWS region `Provider.tf`
- Instance type `Instance.tf`
- IP in Security Group `SecurityGroup.tf`
- Key pair `KeyPair.tf`
- Variables `vars.tf`

## Troubleshooting

Common issues:
1. "AWS credentials not found" - Run `aws configure` to set up your AWS credentials
2. "Permission denied" - Ensure your AWS user has appropriate permissions
3. "Resource already exists" - Make sure you're not trying to create resources that already exist

## Security Best Practices

- Never commit AWS credentials to version control
- Review security group rules before applying
- Keep your SSH private key secure

## Need Help?

- Check [Terraform documentation](https://www.terraform.io/docs)
- Visit [AWS documentation](https://docs.aws.amazon.com)
- Review the code comments in the .tf files for detailed explanations



