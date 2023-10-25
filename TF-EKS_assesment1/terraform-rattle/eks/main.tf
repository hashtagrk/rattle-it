module "vpc" {
  source = "../vpc"  # Relative path to the moduleB directory
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "Rattle-eks-cluster"
  cluster_version = "${var.eks_cluster_version}"

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

resource "kubernetes_service_account" "hello_app_service_account" {
  metadata {
    name      = "hello-app-service-account"
    namespace = namespace.kubernetes_namespace.hello.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "hello_app_cluster_role" {
  metadata {
    name = "hello-app-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "create", "delete"]
  }
}

resource "kubernetes_cluster_role_binding" "hello_app_cluster_role_binding" {
  metadata {
    name = "hello-app-cluster-role-binding"
  }¸

  role_ref {
    kind = "ClusterRole"
    name = kubernetes_cluster_role.hello_app_cluster_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.hello_app_service_account.metadata[0].name
    namespace = namespace.kubernetes_namespace.hello.metadata[0].name
  }
}
