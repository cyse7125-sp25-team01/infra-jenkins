variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the application security group"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instance in"
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

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "key_pair" {
  description = "Key Pair"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the EC2 instance."
  type        = string
}

variable "admin_email"{
  description="Email of the Admin for SSL"
  type=string
}

variable "jenkins_domain"{
  description = "Domain of the hosted Jenkins App"
  type=string
}