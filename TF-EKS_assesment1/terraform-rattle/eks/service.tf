resource "kubernetes_service" "my_app_service" {
  metadata {
    name = "hello-world-svc"
  }

  spec {
    selector = {
      app = "hello-world-app"
    }
    port {
      protocol    = "TCP"
      port        = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}
