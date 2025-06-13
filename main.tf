module "vpc" {
  source = "./modules/vpc"

  cidr_block                  = var.vpc_cidr
  public_subnet_1_cidr_block  = var.public_subnet_1_cidr
  public_subnet_2_cidr_block  = var.public_subnet_2_cidr
  public_subnet_1_az          = var.public_subnet_1_az
  public_subnet_2_az          = var.public_subnet_2_az
  private_subnet_1_cidr_block = var.private_subnet_1_cidr
  private_subnet_2_cidr_block = var.private_subnet_2_cidr
  private_subnet_1_az         = var.private_subnet_1_az
  private_subnet_2_az         = var.private_subnet_2_az
}

module "iam" {
  source = "./modules/iam"

  name                                             = var.name
  aws_iam_openid_connect_provider_arn              = module.eks.aws_iam_openid_connect_provider_arn
  aws_iam_openid_connect_provider_extract_from_arn = module.eks.aws_iam_openid_connect_provider_extract_from_arn
}

module "eks" {
  source = "./modules/eks"

  name                        = var.name
  cluster_role_arn            = module.iam.eks_cluster_role_arn
  public_subnets              = module.vpc.public_subnet_ids
  private_subnets             = module.vpc.private_subnet_ids
  node_role_arn               = module.iam.eks_node_role_arn
  vpc_id                      = module.vpc.vpc_id
  cluster-role-dependency     = module.iam.eks_role_depends_on
  eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint
  security_group_ids          = [module.eks.eks_security_group_id]
}

module "helm" {
  source = "./modules/helm-k8s"

  cluster_id                         = module.eks.cluster_id
  cluster_endpoint                   = module.eks.cluster_endpoint
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  lbc_iam_depends_on                 = module.iam.lbc_iam_depends_on
  lbc_iam_role_arn                   = module.iam.lbc_iam_role_arn
  vpc_id                             = module.vpc.vpc_id
  aws_region                         = "us-east-1"
}