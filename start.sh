#!/bin/bash

service ssh start
/etc/init.d/vsftpd start
/etc/init.d/mysql start
/etc/init.d/apache2 start

if [ ! -f "/home/wing-cms-api/server-config.js" ]; then
	cd /home/wing-cms-api
	cp config/server-config-template.js config/server-config.js
	if [ "$MACVLAN" = true ]; then
		cp config/database-config-template.js config/database-config.js
	else
		cp config/database-config-template-docker.js config/database-config.js
	fi
fi

if [ ! -f "/home/wing-cms/server-config.js" ]; then
	cd /home/wing-cms
	cp config/server-config-template.js config/server-config.js
fi

echo $TEST
if [ "$TEST" = true ]
then
	cd /home/wing-cms-api
	cp config/database-config-template-docker.js tests/config/database-config.js
	cp config/server-config-template.js tests/config/server-config.js
	cp config/cdn-config-template.js tests/config/cdn-config.js
	#npm i -g jest-cli
	npm run test
fi
node /home/wing-cms-api/server.js &
node /home/wing-cms/server.js &