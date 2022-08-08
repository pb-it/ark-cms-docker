# wing-cms-mysql


## Build

```bash
docker build . -t \<image-name\> --progress=plain
```

or pull prebuild from Docker Hub

```bash
docker pull patrickbauerit/wing-cms-mysql:latest
```

### Specific version (build script compatible with git tags >= 0.1.1-beta)

```bash
docker build . -t \<image-name\> --progress=plain --build-arg GIT_TAG=<tag>
```


## Run

```bash
docker run -p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -d \<image-name-or-id\>
```

connect to bash (get id with 'docker ps -a')

```bash
docker exec -it \<container-name-or-id\> bash
```

or start interactive with bash

```bash
docker run -p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -it \<image-name-or-id\> /bin/bash
```

if you are going to upload files and won't store them in the database you can access them afterwards without FTP or you can start the container with an mounting:

```bash
docker run --name \<name\> \
	-p 20-22:20-22 -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000
	--mount type=bind,source=\<your host path\>,target=/var/www/html/cdn
	-it \<image-name-or-id\> /bin/bash
```