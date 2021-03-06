#!/usr/bin/env bash

# IMORTANT you have to check the right version before running this!
# For the future: add some kind of parser for this... (the install via npm somehow does not work...)
BROWSERSOLIDITYVERSION='8f8ffa0'

# install curl and git
sudo apt-get update
sudo apt-get install -y curl git

# install geth (Ethereum-Go, Command-Line client)
echo "##################################################"
echo "INSTALL: Geth"
echo "##################################################"
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y geth
mkdir -p .ethereum/rinkeby/
sudo chown -R vagrant:vagrant .ethereum/

# install NodeJs
# source: https://nodejs.org/en/download/package-manager/
echo "##################################################"
echo "INSTALL: NodeJs"
echo "##################################################"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs
# nom should already come bundled with nodejs in v6.x
#sudo apt-get install -y npm 

# configure npm so it uses global-module directory in vagrant user files
# see: https://stackoverflow.com/questions/29468404/gyp-warn-eacces-user-root-does-not-have-permission-to-access-the-dev-dir
# see: https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
echo "##################################################"
echo "Configure NodeJs Global"
echo "##################################################"
mkdir "/home/vagrant/.npm-packages"
npm config set prefix "/home/vagrant/.npm-packages"
echo 'export PATH=$PATH:/home/vagrant/.npm-packages/bin' >> /home/vagrant/.profile

# truffle framework
echo "##################################################"
echo "INSTALL: truffle"
echo "##################################################"
npm install -g truffle

# install testrpc
echo "##################################################"
echo "INSTALL: testrpc"
echo "##################################################"
npm install -g ethereumjs-testrpc

# install browser solidity locally to have a stable offline environment
echo "##################################################"
echo "INSTALL: browser-solidity"
echo "##################################################"
mkdir browser-solidity
cd browser-solidity
wget 'https://github.com/ethereum/browser-solidity/raw/gh-pages/remix-'"$BROWSERSOLIDITYVERSION"'.zip'
unzip remix-"$BROWSERSOLIDITYVERSION".zip
rm remix-"$BROWSERSOLIDITYVERSION".zip
cd ..
sudo chown -R vagrant:vagrant browser-solidity/

