provider "aws" {
    region = "us-east-1"
}

variable "ingressrules" {
    type = list(number)
    default = [80,443]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}

resource "aws_instance" "ec2" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic"{
    name = "Allow HTTPS"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingressrules
        content { 
        from_port = 443
        to_port = 443
        protocol = "TPC"
        cidr_blocks = ["0.0.0.0/0"]
        }   
    }


    dynamic "egress" {
        iterator = port 
        for_each = var.egressrules
        content { 
        from_port = 443
        to_port = 443
        protocol = "TPC"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}
