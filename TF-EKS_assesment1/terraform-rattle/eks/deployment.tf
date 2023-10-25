resource "kubernetes_deployment" "my_app" {
  metadata {
    name = "my-app-deployment"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "hello-world-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world-app"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "rajkz/hello-world:latest"
        }
      }
    }
  }
}
