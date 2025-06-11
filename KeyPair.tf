# -----------------------------------------------------------------------------
# AWS Key Pair Resource
#
# This resource creates an AWS EC2 Key Pair, which is used to enable SSH access
# to EC2 instances. The key pair consists of a public key (provided here) and
# a private key (kept securely by the user). The key_name uniquely identifies
# the key pair in AWS.
#
# Arguments:
#   key_name   - (Required) The name for the key pair created in AWS.
#   public_key - (Required) The public SSH key to associate with the key pair.
#
# Note:
#   - Replace "Your Public SSH Key" with your actual SSH public key.
#   - Ensure the public key is in the correct OpenSSH format.
# -----------------------------------------------------------------------------

resource "aws_key_pair" "terraform-vpc-ssh-key" {
  key_name   = "terraform-vpc-ssh-key" #REPLACE WITH YOUR SSH KEY NAME                                                                          # Replace with your SSH key name
  public_key = "REPLACE PUBLIC KEY" # Replace with your actual public key
}
