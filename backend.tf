#----------------------------------------------------------------------
# Terraform Backend Configuration
#
# This block configures the backend for storing Terraform state files.
# Using the "s3" backend allows the state to be stored remotely in an
# AWS S3 bucket, enabling collaboration and state locking.
#
# - bucket: Name of the S3 bucket to store the state file.
# - key: Path within the bucket where the state file will be stored.
# - region: AWS region where the S3 bucket is located.
#
# NOTE: Ensure the S3 bucket exists and proper IAM permissions are set.
#----------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket = "REPLACE-WITH-YOUR_BUCKET-NAME" # Replace with your S3 bucket name
    key    = "terraform/tfstate"    # Path within the bucket
    # This key can be customized based on your project structure
    # For example, you might use "terraform/production/tfstate" for production environments.
    region = "us-east-2" # Specify your AWS region
  }
}