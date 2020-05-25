#!/usr/bin/env bash

set -e

sudo systemctl stop apt-daily.service
sudo systemctl kill --kill-who=all apt-daily.service

# wait until `apt-get updated` has been killed
while ! (sudo systemctl list-units --all apt-daily.service | egrep -q '(dead|failed)')
do
  sleep 1;
done
