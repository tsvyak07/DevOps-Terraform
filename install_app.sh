#! /bin/bash
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y maven
sudo apt-get install -y wget
sudo apt-get install -y docker.io
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
cd boxfuse-sample-java-war-hello/
mvn clean install
