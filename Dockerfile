include(bionic)

### add mariadb repo
ENV MARIADB_VERSION 10.2
RUN apt install --yes software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository "deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/$MARIADB_VERSION/ubuntu artful main" && \
    apt update

### install mariadb-server while keeping any existing config files unchanged
RUN DEBIAN_FRONTEND=noninteractive apt install --yes \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        mariadb-server-$MARIADB_VERSION \
        mariadb-client-$MARIADB_VERSION \
        mariadb-backup-$MARIADB_VERSION

### allow requests from the network
RUN sed -i /etc/mysql/my.cnf -e 's/^bind-address/#bind-address/'
