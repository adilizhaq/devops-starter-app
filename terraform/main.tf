terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "app_port" {
  description = "External port to expose the Flask app"
  type        = number
  default     = 5000
}

resource "docker_image" "app" {
  name         = "devops-starter-app:v1"
  keep_locally = true
}

resource "docker_container" "app" {
  name  = "tf-devops-app"
  image = docker_image.app.image_id

  ports {
    internal = 5000
    external = var.app_port
  }
}

output "app_url" {
  value = "http://localhost:${var.app_port}"
}