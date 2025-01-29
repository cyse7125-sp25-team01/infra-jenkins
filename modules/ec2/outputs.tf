output "app_instance_public_ip" {
  value       = aws_instance.app_instance.public_ip
  description = "Public IP address of the EC2 instance"
}

output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.app_instance.id
}

output "iam_instance_profile" {
  description = "The IAM Instance Profile of the created EC2 instance"
  value       = aws_instance.app_instance.iam_instance_profile
}
