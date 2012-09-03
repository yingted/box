#!/bin/sh
sudo ./bind.sh
sudo tee /sys/fs/selinux/enforce <<< 0
sudo service httpd start
