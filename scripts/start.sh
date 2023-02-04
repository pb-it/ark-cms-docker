#!/bin/bash

#apt update && apt upgrade -y

service ssh start
if [ -f "/etc/init.d/vsftpd" ] ; then /etc/init.d/vsftpd start ; fi

/etc/init.d/mysql start

if [ "$PROXY" = true ] ; then
	rm /etc/nginx/sites-enabled/default
	ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/default ;
fi
/etc/init.d/nginx start

if [ "$OS" = "win" ]
then
	cd /home/wing-cms-api
	cp config/database-config-docker.js config/database-config.js
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

if [ -z "$ENV" ] #default environment is development
then
	node /home/wing-cms-api/server.js &
	#node --max-old-space-size=8192 /home/wing-cms-api/server.js &
	node /home/wing-cms/server.js &
else 
	NODE_ENV=$ENV node /home/wing-cms-api/server.js &
	NODE_ENV=$ENV node /home/wing-cms/server.js &
fi