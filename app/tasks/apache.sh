#!/bin/bash
set -e

echo '---- install Apache'

DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

cat > /var/www/html/index.html <<HERE
Hello There, this is Sourish Banerjee !
HERE
