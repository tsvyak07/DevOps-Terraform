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
}
