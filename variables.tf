variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "destination_cidr" {
  description = "CIDR of Destination in route"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default = "Security Group - Ports 22,80, 443"
}


variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "key_pair" {
  description = "Key Pair"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
}
variable "admin_email" {
  description = "Email of the Admin for SSL"
  type        = string
}

variable "jenkins_domain" {
  description = "Domain of the hosted Jenkins App"
  type        = string
}