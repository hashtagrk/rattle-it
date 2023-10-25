variable "eks_cluster_version" {
  description = "The version of the EKS cluster."
  default = "1.24"
}

variable "eks_node_instance_type" {
  description = "The instance type for EKS nodes."
  default = "r6a.2xlarge"
}