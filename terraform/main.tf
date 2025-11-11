# -------------------------------
# Terraform AWS Provider
# -------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

# -------------------------------
# Security Group
# -------------------------------
resource "aws_security_group" "cv_sg" {
  name        = "cv-challenge-sg"
  description = "Allow SSH, HTTP, HTTPS, and monitoring ports"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Monitoring ports (Grafana, Prometheus, Loki, etc.)
  ingress {
    description = "Allow monitoring ports"
    from_port   = 3000
    to_port     = 3100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow metrics ports"
    from_port   = 8080
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cv-challenge-sg"
  }
}

# -------------------------------
# EC2 Instance
# -------------------------------
resource "aws_instance" "cv_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.cv_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "cv-challenge01-server"
  }

  # Install Docker + Python (for Ansible)
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y docker python3 python3-pip
              systemctl enable docker
              systemctl start docker
              usermod -aG docker ec2-user
              EOF

}

# -------------------------------
# Elastic IP
# -------------------------------
resource "aws_eip" "cv_eip" {
  instance = aws_instance.cv_server.id
  domain   = "vpc"

  tags = {
    Name = "cv-instance-eip"
  }
}

# -------------------------------
# Outputs
# -------------------------------
output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.cv_server.id
}

output "instance_public_ip" {
  description = "Elastic (static) Public IP of the deployed EC2 instance"
  value       = aws_eip.cv_eip.public_ip
}
