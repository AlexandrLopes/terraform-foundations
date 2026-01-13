provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic"{
    name = "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TPC"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TPC"
        cidr_blocks = ["0.0.0.0/0"]
    }
}