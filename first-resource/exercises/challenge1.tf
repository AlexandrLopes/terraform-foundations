# =======================================
#Create a new folder called: Challenge1
#Create a VPC named "TerraformVPC"
# CIDR Range: 192.168.0.0/24
# =======================================

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = "TerraformVPC"
  }
}

#terraform init
#terraform plan
#terraform apply

