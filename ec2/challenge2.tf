# =========================
#Create a DB Server and Create output the private IP
#Create a web server and ensure it has a fixed public IP
#Create a Security Group for the web server opening ports 80 and 443 (HTTP and HTTPS)
#Run the provided script on the web server
# =========================


resource "aws_instance" "db_server" {
    ami = "ami-07ff62358b87c7116"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]

    tags = {
        Name = "DB Server"
    }
}

output "db_private_ip" {
    value = aws_instance.db_server.private_ip
}

resource "aws_security_group" "webtraffic" {
    name        = "Allow Web Traffic"
    description = "Allow HTTP and HTTPS inbound traffic"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"   
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"   
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web_server" {
    ami             = "ami-07ff62358b87c7116"
    instance_type   = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    tags = {
        Name = "Web Server"
    }

    # CORRIGIDO: O user_data agora está DENTRO do resource e tem o EOF no final
    user_data = <<-EOF
              #!/bin/bash
              sudo yum update
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF
}

resource "aws_eip" "web_eip" {
    instance = aws_instance.web_server.id
}

output "web_public_ip" {
    value = aws_eip.web_eip.public_ip
}