# wing-cms-mysql

⚠️**WARNING**⚠️

The generated images are for testing puposes only and should not be used in productive way or in public domains!

## Build

```bash
docker build . -t <image-name> --progress=plain
```

> Specific version (build script compatible with git tags >= 0.1.1-beta)
>
> ```bash
> docker build . -t <image-name> --progress=plain --build-arg GIT_TAG=<tag>
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

connect to bash (get id with 'docker ps -a')

```bash
docker exec -it <container-name-or-id> bash
```

or start interactive with bash

```bash
docker run -p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -it <image-name-or-id> /bin/bash
```

When using the internal CDN you can access the files with SCP, FTP or you can start the container with a mounting:

```bash
docker run --name <container-name> \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 \
	--mount type=bind,source=<host-path>,target=/var/www/html/cdn \
	-it <image-name-or-id> /bin/bash
```
