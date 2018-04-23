FROM ubuntu:16.04
ENV container docker
# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;
RUN systemctl set-default multi-user.target
CMD ["/sbin/init"]

RUN apt-get update; apt-get -y upgrade
RUN apt-get -y install rsyslog logrotate ssmtp logwatch cron vim

### add mariadb repo
ENV MARIADB_VERSION 10.2
RUN apt-get -y install software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository "deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main" && \
    apt-get update

### install mariadb-server while keeping any existing config files unchanged
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
         mariadb-server mariadb-client
RUN apt-get -y install mariadb-backup-$MARIADB_VERSION

### allow requests from the network
RUN sed -i /etc/mysql/my.cnf -e 's/^bind-address/#bind-address/'

WORKDIR /host
