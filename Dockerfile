FROM ubuntu:22.04

RUN apt update

RUN apt-get -y install \
	nano \
	mysql-server \
	curl \
	git

#su: warning: cannot change directory to /nonexistent: No such file or directory
#https://stackoverflow.com/questions/62987154/mysql-wont-start-error-su-warning-cannot-change-directory-to-nonexistent
# alternative may be https://ivangogogo.medium.com/docker-use-dockerfile-to-install-mysql-5-7-on-ubuntu-18-04-88e36436f1fd
RUN usermod -d /var/lib/mysql/ mysql

RUN sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

RUN service mysql start && \
	mysql -u root --execute "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES; CREATE SCHEMA xcms" && \
	service mysql stop


RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get -y install \
    nodejs

RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version

# break docker build cache on git update
ADD "https://api.github.com/repos/pb-it/wing-cms-api/commits?per_page=1" latest_commit
ADD "https://api.github.com/repos/pb-it/wing-cms/commits?per_page=1" latest_commit
RUN cd /home && \
	git clone https://github.com/pb-it/wing-cms-api && \
	git clone https://github.com/pb-it/wing-cms

WORKDIR /home/wing-cms-api
RUN npm install --legacy-peer-deps

WORKDIR /home/wing-cms
RUN npm install

WORKDIR /home
RUN printf "/etc/init.d/mysql start\nnode /home/wing-cms-api/japi.js &\nnode /home/wing-cms/xcms.js" > start.sh && \
	chmod +x start.sh

EXPOSE 3306 3002 4000

CMD ["/bin/sh", "start.sh"]