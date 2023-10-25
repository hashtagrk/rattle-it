output "namespace_name" {
  value = module.eks.namespace_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}