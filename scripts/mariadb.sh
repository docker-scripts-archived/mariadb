#!/bin/bash -x

source /host/settings.sh

### add mariadb repo
apt-get -y install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/$VERSION/ubuntu xenial main'
apt-get update

### install mariadb-server while keeping any existing config files unchanged
DEBIAN_FRONTEND=noninteractive apt-get -y install \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    mariadb-server
