#!/bin/bash

# install docker
apt-get update
apt-get -y install docker.io

# update to the latest version (needed to use the 'exec' command)
curl -sSL https://get.docker.com/ubuntu | sudo sh

# clone the sources
mkdir /workspace
cd /workspace
git clone https://github.com/robbertvdzon/contactdb.v2.git

# build and start the three docker containers:
cd /workspace/contactdb.v2/docker
./cluster_build.sh