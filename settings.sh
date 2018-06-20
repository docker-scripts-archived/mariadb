APP=mariadb

IMAGE=dockerscripts/mariadb
CONTAINER=mariadb

### Uncomment PORTS if you want this mariadb container
### to be accessed from the internet.
#PORTS="3306:3306"

### Gmail account for notifications. This will be used by ssmtp.
### You need to create an application specific password for your account:
### https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882
GMAIL_ADDRESS=
GMAIL_PASSWD=
