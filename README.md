# wing-cms-mysql

All-In-One solution with mysql database, server(backend API) and client(browser) application.

> ⚠️**WARNING**⚠️
>
> The generated images are for testing purposes only and should not be used in productive way or in public domains!


## Build

```bash
docker build . -t <image-name> --progress=plain
# '--build-arg NODE_VERSION=<version>' - '18'(default), '16' , ...
```

### Specific version (build script compatible with git tags >= 0.1.1-beta)

```bash
docker build . -t <image-name> --progress=plain --build-arg CMS_GIT_TAG=<tag>
# also append '--build-arg API_GIT_TAG=<tag>' if versions don't match
```

### Development build

Add `--build-arg BUILD_ENV=development` to install additionial programs


### As an alternative prebuild images can be pulled from Docker Hub

```bash
docker pull patrickbauerit/wing-cms-mysql:<tag>
```
See [https://hub.docker.com/r/patrickbauerit/wing-cms-mysql](https://hub.docker.com/r/patrickbauerit/wing-cms-mysql) for available tags
	

## Run

```bash
docker run -p 20-22:20-22 -p 80:80 -p 443:443 -p 3002:3002 -p 3306:3306 -p 4000:4000 -d <image-name-or-id>
```

You can persist the database in a seperate mount like this:

```bash
docker volume create mysql

docker run --name <container-name> \
	-p 20-22:20-22 -p 80:80 -p 443:443 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-v mysql:/var/lib/mysql \
	-d <image-name-or-id>
```

When using the internal CDN you can access the files with SCP, FTP or you can start the container with a mounting:

```bash
docker run --name <container-name> \
	-p 20-22:20-22 -p 80:80 -p 443:443 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	--mount type=bind,source=<host-path>,target=/var/www/html/cdn \
	-d <image-name-or-id>
```

### Proxy

Add `--env PROXY=true` to map all routes to port 80


### Test

```bash
docker run --name <container-name> \
	--env TEST=true \
	-p 20-22:20-22 -p 80:80 -p 443:443 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-d <image-name-or-id>
```


### Test

```bash
docker run --name <container-name> \
	--env TEST=true \
	-p 20-22:20-22 -p 80:80 -p 443:443 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-d <image-name-or-id>
```


### Troubleshooting

`Error: getaddrinfo ENOTFOUND host.docker.internal`

> while `host.docker.internal` in database-config might work on windows it might fail on linux

> use 'localhost'/'172.17.0.1' instead of 'host.docker.internal' 
>
> or add `--add-host=host.docker.internal:host-gateway` to `docker run`
>
> works starting from major version 20.04 of the docker engine


---

Tested on Ubuntu 22.10 (5.19.0-26-generic, x86_64) with Docker version 20.10.21