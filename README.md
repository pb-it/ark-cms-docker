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

> Specific version (build script compatible with git tags >= 0.1.1-beta)
>
> ```bash
> docker build . -t <image-name> --progress=plain --build-arg CMS_GIT_TAG=<tag>
> # also append '--build-arg API_GIT_TAG=<tag>' if versions don't match
> ```


### As an alternative prebuild images can be pulled from Docker Hub

```bash
docker pull patrickbauerit/wing-cms-mysql:<tag>
```
See [https://hub.docker.com/repository/docker/patrickbauerit/wing-cms-mysql](https://hub.docker.com/repository/docker/patrickbauerit/wing-cms-mysql) for available tags
	

## Run

```bash
docker run -p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -d <image-name-or-id>
```

> on linux you might add `--add-host=host.docker.internal:host-gateway`

connect to bash (get id with 'docker ps -a')

```bash
docker exec -it <container-name-or-id> bash
```

or start interactive with bash

```bash
docker run --name <container-name> \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-it <image-name-or-id> /bin/bash
```

When using the internal CDN you can access the files with SCP, FTP or you can start the container with a mounting:

```bash
docker run --name <container-name> \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	--mount type=bind,source=<host-path>,target=/var/www/html/cdn \
	-it <image-name-or-id> /bin/bash
```


### MACVLAN

```bash
docker run --name <container-name> \
	--env MACVLAN=true \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-d \<image-name-or-id\>
```


### Test

```bash
docker run --name <container-name> \
	--env TEST=true \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	-d \<image-name-or-id\>
```


### Troubleshooting

`Error: getaddrinfo ENOTFOUND host.docker.internal`

> while `host.docker.internal` might work on windows it might fail on linux

> add `--add-host=host.docker.internal:host-gateway` to `docker run`
>
> works starting from major version 20.04 of the docker engine
>
> alternatively add `--env MACVLAN=true` to use 'localhost'/'172.17.0.1' instead of 'host.docker.internal'


---

Tested on Ubuntu 22.10 (5.19.0-26-generic, x86_64) with Docker version 20.10.21