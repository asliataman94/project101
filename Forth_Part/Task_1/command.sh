#/bin/bash
ip=$(cat info.json | grep -m1 PrivateIpAddress | cut -d":" -f2 | cut -d'"' -f2)
sudo sed -i "s/ec2-private_ip/$ip/" terraform.tf
