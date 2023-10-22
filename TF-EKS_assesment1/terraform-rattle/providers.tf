provider "aws" {
  region = "us-west-2"  # Update with your AWS region
}

provider "kubernetes" {
  config_path = "${pathexpand("~/.kube/config")}"  # Update with the path to your kubeconfig file
}