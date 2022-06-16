# wing-cms-mysql

## Build

docker build . -t <image-name> --progress=plain

or pull

docker pull patrickbauerit/wing-cms-mysql:latest

## Run

docker run -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -d \<image-name-or-id\>

connect to bash (get id with 'docker ps -a')

docker exec -it \<container-name-or-id\> bash

or start interactive with bash

docker run -p 80:80 -p 3002:3002 -p 3306:3306 -p 4000:4000 -it \<image-name-or-id\> /bin/bash