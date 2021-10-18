#!/bin/bash

# Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
# Full license terms provided in LICENSE.md file.

DIGITS_NAME=$1
if [ -z "${DIGITS_NAME}" ]; then
    DIGITS_NAME=digits
fi

HOST_DATA_DIR=$2
if [ -z "${HOST_DATA_DIR}" ]; then
    HOST_DATA_DIR=~/digits-data
fi

CONTAINER_DATA_DIR=$3
if [ -z "${CONTAINER_DATA_DIR}" ]; then
    CONTAINER_DATA_DIR=/data
fi

CONTAINER_TAG=$4
if [ -z "${CONTAINER_TAG}" ]; then
    CONTAINER_TAG=20.03-caffe-py3
fi

echo "Container name    : ${DIGITS_NAME}"
echo "Host data dir     : ${HOST_DATA_DIR}"
echo "Container data dir: ${CONTAINER_DATA_DIR}"
echo "Container tag     : ${CONTAINER_TAG}"
DIGITS_ID=`docker ps -aqf "name=^/${DIGITS_NAME}$"`
if [ -z "${DIGITS_ID}" ]; then
    echo "Creating new digits container."
    xhost +
    docker run --runtime nvidia -it --rm \
        --network bridge \
        --name ${DIGITS_NAME} \
        --volume ${HOST_DATA_DIR}:${CONTAINER_DATA_DIR}:rw \
		--detach \
        --publish 8082:5000/tcp \
        nvcr.io/nvidia/digits:${CONTAINER_TAG}
else
    echo "Found digits container: ${DIGITS_ID}."
    # Check if the container is already running and start if necessary.
    if [ -z `docker ps -qf "name=^/${DIGITS_NAME}$"` ]; then
        xhost +local:${DIGITS_ID}
        echo "Starting and attaching to ${DIGITS_NAME} container..."
        docker start ${DIGITS_ID}
        docker attach ${DIGITS_ID}
    else
        echo "Found running ${DIGITS_NAME} container, attaching bash..."
        docker exec -it ${DIGITS_ID} bash
    fi
fi

