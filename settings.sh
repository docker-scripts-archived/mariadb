APP=mariadb

IMAGE=dockerscripts/mariadb
CONTAINER=mariadb

### Uncomment PORTS if you want this mariadb container
### to be accessed from the internet.
#PORTS="3306:3306"

### SMTP server for sending notifications. You can build an SMTP server
### as described here:
### https://github.com/docker-scripts/postfix/blob/master/INSTALL.md
### Comment out if you don't have a SMTP server and want to use
### a gmail account (as described below).
SMTP_SERVER=smtp.example.org
SMTP_DOMAIN=example.org

### Gmail account for notifications. This will be used by ssmtp.
### You need to create an application specific password for your account:
### https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882
GMAIL_ADDRESS=
GMAIL_PASSWD=
