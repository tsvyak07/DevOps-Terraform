terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.20.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "maven" {
  ami           = "ami-0c9354388bb36c088"
  instance_type = "t2.micro"
  key_name = "testawssrv"
  security_groups = ["launch-wizard-1"]
  user_data = "${file("install_app.sh")}"

  tags = {
    Name = "MavenBuilder"
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0c9354388bb36c088"
  instance_type = "t2.micro"
  key_name = "testawssrv"
  security_groups = ["launch-wizard-1"]
  user_data = "${file("install_app2.sh")}"

  tags = {
    Name = "TomcatWeb"
  }
}


provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "tomcat" {
  image = docker_image.tomcat.latest
  name  = "tomcat"
  ports {
    internal = 8080
    external = 9999

  }
}
resource "docker_container" "maven" {
  image = docker_image.maven.latest
  name  = "maven"
}
resource "docker_image" "maven" {
  name = "maven:3.8.6-jdk-11"
}
resource "docker_image" "tomcat" {
  name = "tomcat:9-alpine"
}


