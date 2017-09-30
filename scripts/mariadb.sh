#!/bin/bash -x

### install mariadb-server while keeping any existing config files unchanged
DEBIAN_FRONTEND=noninteractive apt-get -y install \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    mariadb-server
