resource "local_file" "hello_local_file" {
  content = "Hello world from terraform !! second apply"
  filename = "${path.module}/hello_file.txt"
}

resource "local_file" "terraform_commands" {
  content=  <<EOF
  # Terraform Initialization
terraform init

# Create an Execution Plan
terraform plan

# Apply Changes
terraform apply

# Destroy Resources
terraform destroy

# Show Resource Outputs
terraform show

# List Resources
terraform state list

# Import Existing Infrastructure
terraform import <resource_type>.<resource_name> <existing_id>

# Validate Configuration
terraform validate

# Output Values
terraform output

# Terraform Console
terraform console

# Terraform Refresh
terraform refresh

# Terraform Graph
terraform graph | dot -Tpng > graph.png

# List AWS Resources in the State
terraform state list

# Show Resource Attributes
terraform state show <resource_type>.<resource_name>

# Force Unlock State
terraform force-unlock <lock-id>

# Clean Up Local State and Backends
terraform state rm <resource_type>.<resource_name>

# Format Terraform Code
terraform fmt

# Initialize and Upgrade Providers
terraform init -upgrade

# Enable Detailed Logging
export TF_LOG=DEBUG

  EOF
  filename = "${path.module}/cheatsheet.txt"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "region" {
    type = string
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}