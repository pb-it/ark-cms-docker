#!/bin/bash

service ssh start
/etc/init.d/vsftpd start
/etc/init.d/mysql start
/etc/init.d/apache2 start
node /home/wing-cms-api/server.js &
node /home/wing-cms/server.js &