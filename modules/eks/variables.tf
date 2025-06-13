variable "name" {
  description = "name of your eks cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "role arn"
  type        = string
}

variable "public_subnets" {
  description = "public subnets"
  type        = list(string)
}

variable "security_group_ids" {
  description = "security group ids"
  type        = list(string)
}

variable "cluster-role-dependency" {
  description = "clusterrole dependency"
}

variable "node_role_arn" {
  description = "node arn"
  type        = string
}

variable "private_subnets" {
  description = "Name of the private_subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "CIDR Range  to be used on VPC"
  type        = string
}

variable "eks_oidc_root_ca_thumbprint" {}