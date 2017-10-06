cmd_mariadb_help() {
    cat <<_EOF
    mariadb [ create | drop | dump | sql | script ]
        Manage the database of the container '$CONTAINER'.
        - create
              create the database '$DBNAME'
        - drop
              drop the database '$DBNAME'
        - dump
              dump the database '$DBNAME'
        - sql <query>
              run the given sql query on '$DBNAME'
        - script <file.sql>
              run the given sql script on '$DBNAME'

_EOF
}

cmd_mariadb() {
    [[ -n $DBHOST ]] || fail "Error: No DBHOST defined on 'settings.sh'"

    local cmd=$1
    case $cmd in
        sql)
            [[ -n $2 ]] || fail "Usage:\n$(cmd_mariadb_help)"
            ds @$DBHOST exec mysql -e "$2"
            ;;
        drop)
            ds @$DBHOST exec mysql -e "drop database if exists $DBNAME"
            ;;
        create)
            ds @$DBHOST exec mysql -e "
                create database if not exists $DBNAME;
                grant all privileges on $DBNAME.* to '$DBUSER'@'$CONTAINER.$NETWORK' identified by '$DBPASS';
                flush privileges; "
            ;;
        dump)
            ds @$DBHOST exec mysqldump --allow-keywords --opt $DBNAME
            ;;
        script)
            [[ -n $2 ]] || fail "Usage:\n$(cmd_mariadb_help)"
            sqlfile=$2
            ds @$DBHOST exec sh -c "mysql --database=$DBNAME < /host/$sqlfile"
            ;;
        *)
            echo -e "Usage:\n$(cmd_mariadb_help)"
            exit
            ;;
    esac
}
