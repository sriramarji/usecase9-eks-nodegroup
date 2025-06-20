variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "public_subnet_1_cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "public_subnet_2_cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "public_subnet_1_az" {
  type    = string
  default = "us-east-1a"
}

variable "public_subnet_2_az" {
  type    = string
  default = "us-east-1b"
}

variable "private_subnet_1_cidr" {
  type    = string
  default = "192.168.101.0/24"
}

variable "private_subnet_2_cidr" {
  type    = string
  default = "192.168.102.0/24"
}

variable "private_subnet_1_az" {
  type    = string
  default = "us-east-1a"
}
variable "private_subnet_2_az" {
  type    = string
  default = "us-east-1b"
}

variable "name" {
  description = "value"
  type        = string
  default     = "test-eks"
}

# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
