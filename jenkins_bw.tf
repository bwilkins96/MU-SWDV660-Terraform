provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}   

resource "aws_security_group" "jenkins-sg"{
    name = "jenkins-sg"
    description = "Security Group for Jenkins EC2 Server"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["100.6.1.155/32", "3.87.216.0/32"]
    }
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["100.6.1.155/32", "3.87.216.0/32"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["100.6.1.155/32", "3.87.216.0/32"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "jenkins-sg"
    }
}

resource "aws_instance" "jenkins-server" {
    ami = "ami-0edf959c3a97468f8"
    instance_type = "t3a.medium"
    key_name = "Jenkins-Key"
    security_groups = ["${aws_security_group.jenkins-sg.name}"]

    tags = {
        Name = "jenkins-server"
    }
}