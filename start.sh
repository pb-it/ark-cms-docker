#!/bin/bash

service ssh start
/etc/init.d/vsftpd start
/etc/init.d/mysql start
/etc/init.d/apache2 start

echo $TEST
if [ "$TEST" = true ]
then
	cd /home/wing-cms-api
	cp config/database-config-template-docker.js tests/config/database-config.js
	cp config/server-config-template.js tests/config/server-config.js
	#npm i -g jest-cli
	npm run test
fi
node /home/wing-cms-api/server.js &
node /home/wing-cms/server.js &