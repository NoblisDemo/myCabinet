#!/bin/bash

CONTAINER_NAME="18f"
IMAGE_NAME="18f_running"

# stop docker image to grab database
docker stop $CONTAINER_NAME
docker cp $CONTAINER_NAME:/work/prodDb.h2.db ./database/

docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker rmi $IMAGE_NAME
docker build -t="$IMAGE_NAME" .
docker run -d --name $CONTAINER_NAME -m 6144m -p 8080:8080 $IMAGE_NAME:latest