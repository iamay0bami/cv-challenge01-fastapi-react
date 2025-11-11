variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name"
  default     = "cv-challenge01-server-keypair"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID for us-east-1"
  default     = "ami-0c101f26f147fa7fd"
}
