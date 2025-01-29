variable "instance_id" {
  description = "Instance ID of the reated Instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the EC2 instance."
  type        = string
}