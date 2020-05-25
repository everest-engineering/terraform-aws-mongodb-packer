echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sudo apt-get update -y
sudo apt-get install gnupg -y
sudo wget -qO - https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${MONGO_VERSION} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list
sudo apt-get update -y
sudo apt-get install mongodb-org -y
sudo cp /tmp/mongod.conf /etc/mongod.conf
sudo cp /tmp/mount-ebs-volumes.sh /opt/mount-ebs-volumes.sh
