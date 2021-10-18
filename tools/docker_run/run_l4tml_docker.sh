#!/bin/bash

# Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
# Full license terms provided in LICENSE.md file.

L4T_ML_NAME=$1
if [ -z "${L4T_ML_NAME}" ]; then
    L4T_ML_NAME=l4t-ml
fi

HOST_DATA_DIR=$2
if [ -z "${HOST_DATA_DIR}" ]; then
    HOST_DATA_DIR=~/l4tml-data
fi

CONTAINER_DATA_DIR=$3
if [ -z "${CONTAINER_DATA_DIR}" ]; then
    CONTAINER_DATA_DIR=/l4tml-tx2/data
fi

CONTAINER_TAG=$4
if [ -z "${CONTAINER_TAG}" ]; then
    CONTAINER_TAG=r32.5.0-py3
fi

echo "Container name    : ${L4T_ML_NAME}"
echo "Host data dir     : ${HOST_DATA_DIR}"
echo "Container data dir: ${CONTAINER_DATA_DIR}"
echo "Container tag     : ${CONTAINER_TAG}"
L4T_ML_ID=`docker ps -aqf "name=^/${L4T_ML_NAME}$"`
if [ -z "${L4T_ML_ID}" ]; then
    echo "Creating new l4t-ml container."
    xhost +
    docker run --runtime nvidia -it --rm \
        --network bridge \
        --name ${L4T_ML_NAME} \
        --volume ${HOST_DATA_DIR}:${CONTAINER_DATA_DIR}:rw \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume /tmp/argus_socket:/tmp/argus_socket \
        --device /dev/video0 \
        --env DISPLAY=unix${DISPLAY} \
        --publish 8080:8888/tcp \
        nvcr.io/nvidia/l4t-ml:${CONTAINER_TAG}
else
    echo "Found l4t-ml container: ${L4T_ML_ID}."
    # Check if the container is already running and start if necessary.
    if [ -z `docker ps -qf "name=^/${L4T_ML_NAME}$"` ]; then
        xhost +local:${L4T_ML_ID}
        echo "Starting and attaching to ${L4T_ML_NAME} container..."
        docker start ${L4T_ML_ID}
        docker attach ${L4T_ML_ID}
    else
        echo "Found running ${L4T_ML_NAME} container, attaching bash..."
        docker exec -it ${L4T_ML_ID} bash
    fi
fi

