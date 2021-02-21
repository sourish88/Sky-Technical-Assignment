#!/bin/bash
set -e

echo '---- install Apache'

DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y install apache2
export instance_hostname=$(curl http://169.254.169.254/latest/meta-data/hostname)
cat > /var/www/html/index.html <<HERE
Hello There,
This is node:  $instance_hostname
HERE
