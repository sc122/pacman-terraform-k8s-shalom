provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "pacman-vpc-shalom2025"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  map_public_ip_on_launch = true

  tags = {
    Owner   = "shalom2025"
    Project = "pacman"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.4.0"

  cluster_name    = "pacman-eks-shalom2025"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 2
      min_size     = 2

      instance_types = ["t3.medium"]

      iam_role_additional_policies = {
        eks_worker = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        cni        = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        ecr        = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }


      tags = {
        Name = "eks-nodegroup-shalom2025"
      }
    }
  }

  tags = {
    Owner   = "shalom2025"
    Project = "pacman"
  }
}
