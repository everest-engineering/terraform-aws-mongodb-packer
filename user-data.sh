#!/bin/bash
set -e
sudo bash /opt/mount-ebs-volumes.sh
sudo echo "${mongo_key}" > /var/lib/mongodb/keyfile
sudo chmod 400 /var/lib/mongodb/keyfile
sudo chown mongodb:mongodb /var/lib/mongodb/keyfile
sudo systemctl daemon-reload
sudo systemctl start mongod	
sudo systemctl enable mongod.service
sudo touch /tmp/signal
