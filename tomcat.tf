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

resource "docker_container" "tomcat" {
  image = docker_image.tomcat.latest
  name  = "tomcat"
  ports {
    internal = 8080
    external = 6060

  }
}

# Find the latest Nginx precise image.
resource "docker_image" "tomcat" {
  name = "tomcat:9-alpine"
}