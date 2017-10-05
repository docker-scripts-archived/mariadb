cmd_clone_help() {
    cat <<_EOF
    clone <src> <dst>
        Make a copy of <src> database to <dst>

_EOF
}

cmd_clone() {
    local src=$1
    local dst=$2
    [[ -n $src && -n $dst ]] || fail "Usage:\n$(cmd_clone_help)"

    echo "--> Cloning the database $src to $dst ..."

    # create the database
    ds exec mysql -e "
        DROP DATABASE IF EXISTS $dst;
        CREATE DATABASE $dst; "

    # copy the data
    ds exec sh -c \
        "mysqldump --allow-keywords --opt --verbose $src | mysql --database=$dst"
}
