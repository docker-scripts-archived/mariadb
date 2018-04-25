#!/bin/bash -x

# fix permissions
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/run/mysqld

# create system tables, if they don't exist already
[[ -d /var/lib/mysql/mysql ]] || mysql_install_db
