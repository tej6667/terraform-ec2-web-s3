# ------------------------------------------------------------------------
# AWS Provider Configuration
#
# This block configures the AWS provider for Terraform.
# The AWS region is set dynamically using the value of the 'region' variable.
#
# Required Variables:
#   - region: The AWS region where resources will be managed (e.g., "us-east-1").
#
# Ensure that your AWS credentials are configured via environment variables,
# shared credentials file, or another supported method.
# ------------------------------------------------------------------------

provider "aws" {
  region = var.region
}
    