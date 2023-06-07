#!/usr/bin/env bash

SOURCE_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
cd ${SOURCE_DIR}

DOCKER_IMAGE='ssl_test_with_nginx:latest'
DOCKER_CONTAINER_NAME='nginx'


case "$1" in
    "build") docker image build -t ${DOCKER_IMAGE} .;;
    "login")
        docker container exec \
            -it ${DOCKER_CONTAINER_NAME} /bin/bash;;
    "rmc")docker container rm -f ${DOCKER_CONTAINER_NAME};;
    "rmi")docker image rm -f ${DOCKER_IMAGE};;
    "run_first")
        # Don't mount volume
        docker container run \
            -dit \
            -p 80:80 \
            -p 443:443 \
            --name ${DOCKER_CONTAINER_NAME} \
            ${DOCKER_IMAGE};;
    "run")
        # mount volume
        docker container run \
            -dit \
            -p 80:80 \
            -p 443:443 \
            -v ${SOURCE_DIR}/nginx:/etc/nginx \
            --name ${DOCKER_CONTAINER_NAME} \
            ${DOCKER_IMAGE};;
    "cp")docker container cp\
        ${DOCKER_CONTAINER_NAME}:/etc/nginx ${SOURCE_DIR};;
    "logs")docker container logs ${DOCKER_CONTAINER_NAME};
esac
