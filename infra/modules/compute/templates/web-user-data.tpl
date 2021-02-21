#!/bin/bash
# Start apache web server
export instance_hostname=$(curl http://169.254.169.254/latest/meta-data/hostname)
cat > /var/www/html/index.html <<HERE
Hello There,
This is node:  $instance_hostname
HERE

sudo /etc/init.d/apache2 start