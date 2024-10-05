#!/bin/bash

# All the next steps should be running on the AWS EC2 test-instance!


# Configure the instance itself to receive and send the traffic on ports: 8080/80
echo "Configuring iptables..."
# sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
# sudo iptables -A INPUT -p tcp -m tcp --sport 80 -j ACCEPT
# sudo iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT

# Dowload Node.js server script
echo "Downloading the Node.JS"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
sleep 10

echo "npm install and configuring..."
node --version
sudo npm install express -g

sudo yum install git -y
git --version

echo "Pull in the sample of code"
git clone https://github.com/BackSpaceTech/node-js-sample.git
sleep 10

cd node-js-sample
sudo npm install
DEBUG=node-js-sample:* sudo npm start

