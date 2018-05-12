# MariaDB in a Container

## Installation

  - First install `ds`: https://github.com/docker-scripts/ds#installation

  - Then get the scripts from github: `ds pull mariadb`

  - Create a directory for the container: `ds init mariadb @mariadb`

  - Fix the settings: `cd /var/ds/mariadb/ && vim settings.sh`

  - Build image, create the container and configure it: `ds make`
