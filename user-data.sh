#!/bin/bash
#sudo rm -rf /var/lib/cloud
echo ${mongo_key} > /var/lib/mongodb/keyfile
sudo chmod 400 /var/lib/mongodb/keyfile
sudo chown mongodb:mongodb /var/lib/mongodb/keyfile
sudo systemctl daemon-reload
sudo systemctl start mongod	
sudo systemctl enable mongod.service