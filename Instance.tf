# -----------------------------------------------------------------------------
# AWS EC2 Instance Resource for Web Server
# -----------------------------------------------------------------------------
# This resource creates an EC2 instance using the specified AMI and instance type.
# - The AMI ID is dynamically selected based on the region from the `amiID` variable.
# - The instance type is set to `t2.micro` for cost-effective usage.
# - The SSH key pair `terraform-mpro-key` is used for secure access.
# - The instance is associated with a security group defined in `SecurityGroup.tf`.
# - The instance is launched in the availability zone specified by `var.zone1`.
# - Tags are applied for identification and project tracking.
#
# Connection Block:
# - Configures SSH access using the username from `var.webuser` and the private key file.
# - Uses the instance's public IP for remote access.
#
# Provisioner Block:
# - Executes a shell script (`/tmp/web.sh`) on the instance after launch.
# - Ensures the script is executable and runs it with sudo privileges.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# AWS EC2 Instance State Resource
# -----------------------------------------------------------------------------
# This resource ensures the EC2 instance remains in the "running" state.
# - References the instance created above.
# - Helps maintain the desired state of the instance.
# -----------------------------------------------------------------------------

resource "aws_instance" "web" {
  ami                    = var.amiID[var.region] # Reference the AMI ID from the variable defined in variables.tf
  instance_type          = "t2.micro"
  key_name               = "terraform-mpro-key"                           # Your SSH key pair name
  vpc_security_group_ids = [aws_security_group.terraform-ec2-setup-sg.id] # Reference the security group created in SecurityGroup.tf
  availability_zone      = var.zone1                                      # Specify the availability zone


  tags = {
    Name    = "web"
    Project = "terraform-ec2-web-s3"
  }
  connection {
    type        = "ssh"                      # Use SSH for connection
    user        = var.webuser                # Username for SSH connection, defined in variables.tf
    private_key = file("terraform-mpro-key") # Path to your private key file
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh", # Ensure the script is executable
      "sudo /tmp/web.sh" # Execute the script with sudo privileges
    ]
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running" # Ensure the instance is in a running state
}
