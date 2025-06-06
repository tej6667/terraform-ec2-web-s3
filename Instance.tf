# -----------------------------------------------------------------------------
# AWS EC2 Instance Resource for Web Server
# -----------------------------------------------------------------------------
# This resource creates an EC2 instance using the specified AMI and instance type.
# - The AMI ID is dynamically selected based on the region from the `amiID` variable.
# - The instance is launched in the specified availability zone (`zone1`).
# - The instance uses a specified SSH key pair for access.
# - Security group is referenced from a separately defined resource.
# - Tags are applied for identification and project tracking.
#
# Connection Block:
# - Configures SSH connection using the provided username and private key.
# - The connection is used for provisioning and remote execution.
#
# Provisioners:
# - `remote-exec`: Executes a shell script (`web.sh`) on the instance after launch.
# - `local-exec`: Appends the instance's private IP to a local file (`private_ips.txt`).
#
# -----------------------------------------------------------------------------
# AWS EC2 Instance State Resource
# -----------------------------------------------------------------------------
# Ensures the EC2 instance is in the "running" state after creation.
#
# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------
# - `WebPublicIP`: Outputs the public IP address of the web instance.
# - `WebPrivateIP`: Outputs the private IP address of the web instance.
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
      "sudo /tmp/web.sh"      # Execute the script with sudo privileges
    ]
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running" # Ensure the instance is in a running state
}

output "WebPublicIP" {
  description = "Public IP of Ubuntu instance"
  value       = aws_instance.web.public_ip # Output the public IP of the web instance
}
output "WebPrivateIP" {
  description = "Private IP of Ubuntu instance"
  value       = aws_instance.web.private_ip # Output the Private IP of the web instance
}