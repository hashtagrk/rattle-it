resource "kubernetes_namespace" "hello" {
  metadata {
    name = "excercise"
  }
}