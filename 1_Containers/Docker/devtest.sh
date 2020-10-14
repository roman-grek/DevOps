#! /bin/bash

sudo docker run -d -it --name devtest --mount type=bind,source="$(pwd)"/nginx/etc,target=/nginx/etc -p 8080:80 nginx
