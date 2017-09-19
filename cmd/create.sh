cmd_create_help() {
    cat <<_EOF
    create
        Create the squid container '$CONTAINER'.

_EOF
}

rename_function cmd_create orig_cmd_create
cmd_create() {
    mkdir -p conf.d data run logs
    orig_cmd_create \
        --mount type=bind,src=$(pwd)/conf.d,dst=/etc/mysql/mariadb.conf.d \
        --mount type=bind,src=$(pwd)/data,dst=/var/lib/mysql \
        --mount type=bind,src=$(pwd)/run,dst=/var/run/mysqld \
        --mount type=bind,src=$(pwd)/logs,dst=/var/log/mysql
}
