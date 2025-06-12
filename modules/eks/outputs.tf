output "eks_security_group_id" {
  description = "Security group ID for the Application Load Balancer"
  value       = aws_security_group.eks.id
}
