terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.20.2"
    }
  }
}

provider "docker" {
  # Configuration options
  host    = "unix:///var/run/docker.sock"

}

resource "docker_container" "nginx" {
  name  = "nginx-test"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 80
  }
}

# Find the latest Nginx precise image.
resource "docker_image" "ubuntu" {
  name = "nginx:latest"
}
