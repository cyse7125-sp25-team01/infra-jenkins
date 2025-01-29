variable "sg_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
  default     = "application-security-group"
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default     = "Application Security Group"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

