#!/bin/bash

#apt update
#apt upgrade -y

service ssh start
if [ -f "/etc/init.d/vsftpd" ]; then /etc/init.d/vsftpd start ; fi
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
	cat <<EOF > config/cdn-config.js
var cdn = [{
    name: "localhost",
    url: "/cdn",
    path: "/var/www/html/cdn/"
}];

module.exports = cdn;
EOF
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