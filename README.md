# Ariadne's Thread Project
Source Code for MSc Thesis: "Autonomous Drones for Trail Navigation using DNNs"

This project contains deep neural networks, computer vision and control code, hardware instructions and other artifacts that allow users to build a drone which can autonomously navigate through highly unstructured environments like forest trails, sidewalks, etc. Our AriadneNet DNN for visual navigation is running on NVIDIA's Jetson TX2 embedded platform.

The project's deep neural networks (DNNs) can be trained from scratch using publicly available data. A few [pre-trained DNNs](./models/pretrained/) are also available as a part of this project. More instructions about the models can be found in [this](./models/Models.md) document.

In case you want to train AriadneNet DNN from scratch, you need to follow the steps on [this page](./models/Training-TrailNet-model.md).

For our algorithms implementation, we chose to use ROS Noetic. All vision-based algorithms and their additional functionalities, are run as services through ROS nodes. More instrucitons about ROS nodes that are used or implemented in the project can be found in [this](./ros/ROS-Nodes.md) document.

