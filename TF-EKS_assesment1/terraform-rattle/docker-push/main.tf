provider "null" {}

resource "null_resource" "build_and_push" {
  #triggers = {
  #  build_trigger = "../../Hello-world-app/Dockerfile"
  #}

  provisioner "local-exec" {
    command = <<EOT
      docker build -t ${var.dockerhub_app_name} -f ../../Hello-world-app/Dockerfile ../../Hello-world-app/
      docker tag ${var.dockerhub_app_name} ${var.dockerhub_username}/${var.dockerhub_app_name}:latest
      docker login -u ${var.dockerhub_username} -p ${var.dockerhub_password}
      docker push  ${var.dockerhub_username}/${var.dockerhub_app_name}:latest
    EOT

    environment = {
      DOCKER_CONFIG = "~/.docker"  # Specify the location of your Docker config
    }
  }
}