output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.app_vpc.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private_subnet[*].id
}