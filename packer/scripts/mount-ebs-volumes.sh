while [ `lsblk -n | grep -c 'xvdf'` -ne 1 ]
do
  echo "Waiting for /dev/xvdf to become available"
  sleep 10
done
sudo mkfs.ext4 /dev/xvdf
sudo mount /dev/xvdf /mnt
sudo echo '/dev/xvdf /mnt/db ext4 defaults 0 0' | sudo tee -a /etc/fstab
sudo mkdir -p /mnt/db
sudo chown -R mongodb /mnt/db
