# wing-cms-mysql

# Build

docker build . -t <image name> --progress=plain

or pull

docker pull patrickbauerit/wing-cms-mysql:latest

# Run

docker run -p 3306:3306 -p 80:80 -p 3002:3002 -p 4000:4000 -d <image name>

or interactive with bash

docker run -p 3306:3306 -p 80:80 -p 3002:3002 -p 4000:4000 -it <image name> /bin/bash