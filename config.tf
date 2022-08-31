terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.20.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "foo" {
  image = docker_image.nginx.latest
   name  = "nginx"
   ports {
    internal = 80
    external = 80

   }
}

# Find the latest Nginx precise image.
resource "docker_image" "nginx" {
  name = "nginx:latest"
}
