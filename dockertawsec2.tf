terraform {
  required_providers {
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
  connection {
    type     = "ssh"
    host     =  self.public_ip
    user     = "ubuntu"
    private_key = "${file("Terraform.pem")}"

  }
  provisioner "file" {
    source      = "boxfuse-sample-java-war-hello/target/"
    destination = "/home/"

  }
  tags = {
    Name = "MavenBuilder"
  }
  root_block_device {
    volume_size         = 15
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0c9354388bb36c088"
  instance_type = "t2.micro"
  key_name = "testawssrv"
  security_groups = ["launch-wizard-1"]
  user_data = "${file("install_app2.sh")}"
  connection {
    type     = "ssh"
    host     =  self.public_ip
    user     = "ubuntu"
    private_key = "${file("Terraform.pem")}"
  }
  provisioner "file" {
    source      = "/home/"
    destination = "/var/lib/tomcat/webapps"

  }
  tags = {
    Name = "TomcatWeb"
  }
  root_block_device {
    volume_size         = 15
  }
}

