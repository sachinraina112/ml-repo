#/bin/bash
echo "Installing docker"
sudo apt update
sudo apt-get install -y docker.io
sudo service docker start
sudo usermod -a -G docker ubuntu
exec sudo su -l ubuntu
