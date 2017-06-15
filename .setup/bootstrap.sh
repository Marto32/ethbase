#!/bin/bash

# Install git for version control, pip for install python packages
echo "Installing base python requirements..."
sudo apt-get -qq -y install git python-dev build-essential automake pkg-config libtool libffi-dev libgmp-dev python-pip libssl-dev > /dev/null 2>&1

# Make geth folders
mkdir -p /home/vagrant/data/chaindata
mkdir -p /home/vagrant/data/keystore
mkdir -p /home/vagrant/data/nodes
mkdir -p /home/vagrant/.setup
cat /vagrant/.setup/TestGenesis.json > /home/vagrant/.setup/TestGenesis.json
cat /vagrant/.setup/init_geth.sh > /home/vagrant/.setup/init_geth.sh && chmod +x /home/vagrant/.setup/init_geth.sh
cat /vagrant/.setup/geth_console.sh > /home/vagrant/.setup/geth_console.sh && chmod +x /home/vagrant/.setup/geth_console.sh
cat /vagrant/.setup/bashrc_additions >> /home/vagrant/.bashrc

# Install ethereum
echo "Installing ethereum..."
sudo apt-get install software-properties-common > /dev/null 2>&1
sudo add-apt-repository -y ppa:ethereum/ethereum > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y install ethereum > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "Successfully installed ethereum!"
else
  echo "Could not install ethereum" >&2
  exit 1
fi

# Install pyethapp
echo "Installing pyethapp..."
pip install pyethapp > /dev/null 2>&1
# Downgrade pyelliptic per https://github.com/ethereum/pyethapp/issues/199
sudo pip install pyelliptic==1.5.7 > /dev/null 2>&1

if [ $? -eq 0 ]
then
  echo "Successfully installed pyethapp"
else
  echo "Could not install pyethapp" >&2
  exit 1
fi

# Complete
echo ""
echo "Vagrant install complete!"
