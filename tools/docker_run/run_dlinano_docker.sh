#!/bin/bash

# Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
# Full license terms provided in LICENSE.md file.

DLI_NANO_AI_NAME=$1
if [[ -z "${DLI_NANO_AI_NAME}" ]]; then
    DLI_NANO_AI_NAME=dli-nano-ai-v2
fi

HOST_DATA_DIR=$2
if [[ -z "${HOST_DATA_DIR}" ]]; then
    HOST_DATA_DIR=~/nvdli-data
fi

CONTAINER_DATA_DIR=$3
if [[ -z "${CONTAINER_DATA_DIR}" ]]; then
    CONTAINER_DATA_DIR=/nvdli-nano/data
fi

CONTAINER_TAG=$4
if [[ -z "${CONTAINER_TAG}" ]]; then
    CONTAINER_TAG=v2.0.1-r32.5.0
fi

echo "Container name    : ${DLI_NANO_AI_NAME}"
echo "Host data dir     : ${HOST_DATA_DIR}"
echo "Container data dir: ${CONTAINER_DATA_DIR}"
echo "Container tag     : ${CONTAINER_TAG}"
DLI_NANO_AI_ID=`docker ps -aqf "name=^/${DLI_NANO_AI_NAME}$"`
if [ -z "${DLI_NANO_AI_ID}" ]; then
    echo "Creating new dli-nano-ai container."
    xhost +
    docker run --runtime nvidia -it --rm \
        --network bridge \
        --name ${DLI_NANO_AI_NAME} \
        --volume ${HOST_DATA_DIR}:${CONTAINER_DATA_DIR} \
        --volume /tmp/argus_socket:/tmp/argus_socket \
        --device /dev/video0 \
        --publish 8081:8888/tcp \
        nvcr.io/nvidia/dli/dli-nano-ai:${CONTAINER_TAG}
    #nvidia-docker run -it --privileged --network=host -v ${HOST_DATA_DIR}:${CONTAINER_DATA_DIR}:rw -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix${DISPLAY} -p 14556:14556/udp --name=${DLI_NANO_AI_NAME} nvcr.io/nvidia/dli/dli-nano-ai:${CONTAINER_TAG} bash
else
    echo "Found dli-nano-ai container: ${DLI_NANO_AI_ID}."
    # Check if the container is already running and start if necessary.
    if [ -z `docker ps -qf "name=^/${DLI_NANO_AI_NAME}$"` ]; then
        xhost +local:${DLI_NANO_AI_ID}
        echo "Starting and attaching to ${DLI_NANO_AI_NAME} container..."
        docker start ${DLI_NANO_AI_ID}
        docker attach ${DLI_NANO_AI_ID}
    else
        echo "Found running ${DLI_NANO_AI_NAME} container, attaching bash..."
        docker exec -it ${DLI_NANO_AI_ID} bash
    fi
fi
