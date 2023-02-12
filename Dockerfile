FROM ubuntu:latest

LABEL authors="Patrick Bauer <admin@pb-it.at>"
LABEL title="wing-cms-mysql"
LABEL description="CMS with headless API backend using mysql database"

ARG BUILD_ENV="production"
ARG CMS_GIT_TAG
ARG API_GIT_TAG

RUN apt-get update && \
	apt-get install -y \
	dos2unix \
	curl \
	git \
	mysql-server \
	nginx

RUN echo "$BUILD_ENV"
RUN if [ "$BUILD_ENV" = "development" ] ; then \
		apt-get install -y \
			nano \
			openssh-server \
			cifs-utils \
			vsftpd \
			subversion ; \
		echo 'root:docker' | chpasswd ; \
		sed -i 's/\(#\|\)PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config ; \
		#mv /etc/vsftpd.conf /etc/vsftpd.conf.orig ; \
	fi

WORKDIR /home
COPY ssl ssl
RUN rm -f ssl/.gitignore && \
	if [ -z "$(ls -A ssl)" ] ; then \
    	openssl req -x509 -newkey rsa:4096 -keyout ssl/key.pem -out ssl/cert.pem -days 365 -subj '/CN=localhost' -nodes ; \
	fi

COPY scripts scripts
RUN dos2unix scripts/setup_mysql.sh && chmod +x scripts/setup_mysql.sh
RUN dos2unix scripts/setup_api.sh && chmod +x scripts/setup_api.sh
RUN dos2unix scripts/setup_cms.sh && chmod +x scripts/setup_cms.sh
RUN dos2unix scripts/start.sh && chmod +x scripts/start.sh


RUN scripts/setup_mysql.sh


ARG NODE_VERSION
RUN if [ -z "$NODE_VERSION" ] ; then \
		curl -fsSL https://deb.nodesource.com/setup_18.x | bash - ; \
	else \
		curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - ; \
	fi
RUN apt-get -y install \
    nodejs
RUN echo "NODE Version: $(node --version)"
RUN echo "NPM Version: $(npm --version)"


#COPY src/* .

# break docker build cache on git update
ADD "https://api.github.com/repos/pb-it/wing-cms-api/commits?per_page=1" latest_commit
RUN if [ ! -d "wing-cms-api" ] ; then bash scripts/setup_api.sh ; fi
COPY config/api-server-config.js wing-cms-api/config/server-config.js
COPY config/database-config-localhost.js wing-cms-api/config/database-config-localhost.js
COPY config/database-config-localhost.js wing-cms-api/config/database-config.js
COPY config/database-config-docker.js wing-cms-api/config/database-config-docker.js
COPY config/cdn-config.js wing-cms-api/config/cdn-config.js
RUN rm -r wing-cms-api/config/ssl && ln -s /home/ssl wing-cms-api/config/ssl

# break docker build cache on git update
ADD "https://api.github.com/repos/pb-it/wing-cms/commits?per_page=1" latest_commit
RUN if [ ! -d "wing-cms" ] ; then bash scripts/setup_cms.sh ; fi
COPY config/cms-server-config.js wing-cms/config/server-config.js


RUN mkdir /var/www/html/cdn
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/_default
COPY nginx/* /etc/nginx/sites-available/


COPY pm2/ecosystem.config.js .
RUN npm install pm2 -g


EXPOSE 20-22 80 443 3002 3306 4000

CMD bash /home/scripts/start.sh && tail -f /dev/null
#ENTRYPOINT tail -f /dev/null