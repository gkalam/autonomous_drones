#!/bin/bash

# Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
# Full license terms provided in LICENSE.md file.

L4T_VERSION="r32.5.0"
ROS_DISTRO="noetic"

L4T_ROS_NAME=$1
if [ -z "${L4T_ROS_NAME}" ]; then
    L4T_ROS_NAME=l4t-ros-noetic
fi

HOST_DATA_DIR=$2
if [ -z "${HOST_DATA_DIR}" ]; then
    HOST_DATA_DIR=~/l4tml-data
fi

CONTAINER_DATA_DIR=$3
if [ -z "${CONTAINER_DATA_DIR}" ]; then
    CONTAINER_DATA_DIR=/l4tml-tx2/data
fi

NVIDIA_DOCKER_VOLUME=$4
if [[ -n "${NVIDIA_DOCKER_VOLUME}" ]]; then
    NVIDIA_DOCKER_VOLUME_PARAM="-v ${NVIDIA_DOCKER_VOLUME}:/usr/local/nvidia:ro"
fi

echo "Container name    : ${L4T_ROS_NAME}"
echo "Host data dir     : ${HOST_DATA_DIR}"
echo "Container data dir: ${CONTAINER_DATA_DIR}"
echo "NVIDIA Docker vol : ${NVIDIA_DOCKER_VOLUME}"
L4T_ROS_ID=`docker ps -aqf "name=^/${L4T_ROS_NAME}$"`
if [ -z "${L4T_ROS_ID}" ]; then
    echo "Creating new l4t-ros-noetic container."
    xhost +
    docker run --runtime nvidia -it --rm \
        --network bridge \
        --name ${L4T_ROS_NAME} \
        --volume ${HOST_DATA_DIR}:${CONTAINER_DATA_DIR}:rw \
        ${NVIDIA_DOCKER_VOLUME_PARAM} \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --env DISPLAY=unix${DISPLAY} \
        ros:$ROS_DISTRO-ros-base-l4t-$L4T_VERSION bash
else
    echo "Found l4t-ros-noetic container: ${L4T_ROS_ID}."
    # Check if the container is already running and start if necessary.
    if [ -z `docker ps -qf "name=^/${L4T_ROS_NAME}$"` ]; then
        xhost +local:${L4T_ROS_ID}
        echo "Starting and attaching to ${L4T_ROS_NAME} container..."
        docker start ${L4T_ROS_ID}
        docker attach ${L4T_ROS_ID}
    else
        echo "Found running ${L4T_ROS_NAME} container, attaching bash..."
        docker exec -it ${L4T_ROS_ID} bash
    fi
fi

