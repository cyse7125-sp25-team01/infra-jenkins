output "iam_instance_profile" {
  description = "The IAM Instance Profile of the created EC2 instance"
  value = aws_iam_instance_profile.jenkins_instance_profile.name
}