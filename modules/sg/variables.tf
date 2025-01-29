variable "sg_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default = "Security Group - Ports 22,80, 443"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}


