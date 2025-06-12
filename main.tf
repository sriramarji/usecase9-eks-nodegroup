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
}

module "eks" {
  source = "./modules/eks"

  name                    = var.name
  cluster_role_arn        = module.iam.eks_cluster_role_arn
  public_subnets          = module.vpc.public_subnet_ids
  private_subnets         = module.vpc.private_subnet_ids
  node_role_arn           = module.iam.eks_node_role_arn
  vpc_id                  = module.vpc.vpc_id
  cluster-role-dependency = module.iam.eks_role_depends_on
  security_group_ids      = [module.eks.eks_security_group_id]
}