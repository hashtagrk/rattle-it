module "vpc" {
  source = "../vpc"  # Relative path to the moduleB directory
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "Rattle-eks-cluster"
  cluster_version = "1.24"

  subnets = vpc.aws_subnet.private_subnet[*].id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2

      instance_type = "${var.eks_node_instance_type}"
    }
  }
}

module "namespace" {
  source = "./namespace.tf"
}

module "deployment" {
  source = "./deployment.tf"
}

module "service" {
  source = "./service.tf"
}