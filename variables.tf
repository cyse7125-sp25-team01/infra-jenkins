variable "profile" {
  description = "AWS CLI profile to use"
  default     = "root"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

# Variables for VPC Module

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "default-vpc-name"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "destination_cidr" {
  description = "CIDR of Destination in route"
  default     = "0.0.0.0/0"
}

# New Variables for Security Group and EC2 Instance
variable "sg_name" {
  description = "Name of the security group for EC2 instances"
  default     = "application-security-group"
}

variable "sg_description" {
  description = "Description of the security group"
  default     = "Security group for EC2 instances"
}

variable "app_port" {
  description = "Port on which the application runs"
  default     = 8080
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-01732d96e0001c4e2"
}


variable "key_pair" {
  description = "Key Pair"
  type        = string
  default     = "testing-key"
}

variable "instance_type" {
  description = "The instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "jenkins-test"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 25
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp2"
}
