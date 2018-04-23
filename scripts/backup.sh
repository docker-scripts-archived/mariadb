#!/bin/bash -x

# get the name of the backup file
backup=$1 ; shift
[[ -z $backup ]] && echo "Usage: $0 <backup-name> [<dbname>...]" && exit 1

# get the databases that will be archived
databases="$@"

# make the backup
rm -rf /host/$backup
mariabackup \
    --defaults-file=/etc/mysql/debian.cnf \
    --backup \
    --databases="$databases" \
    --target-dir=/host/$backup

# create an archive file
cd /host/
rm -f $backup.tgz
tar --create --gzip --file=$backup.tgz $backup

# clean up
rm -rf $backup
