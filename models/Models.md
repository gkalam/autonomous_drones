# TrailNet models
This document describes how to create TrailNet model from scratch using NVIDIA DIGITS.

## Creating a dataset
First, we need to create a dataset in DIGITS. Follow the steps in [this](../tools/camera_rig/Datasets.md) document.

## Using an existing dataset
The IDISA Forest Trail dataset is publicly available [here](http://bit.ly/perceivingtrails). Follow the steps in [this](./dataset-idsia/Idsia-DataSet.md) document.

For our dataset (Zografou University Campus) follow the steps in [this](./dataset-di.uoa.gr/di.uoa.gr-DataSet.md) document.

## Training a model
Once the dataset is created, the model can be trained and fine-tuned using DIGITS. Follow the steps in [this](./Training-TrailNet-model.md) document.

## Deploying a model
Once the model is trained, resulting `.prototxt` and `.caffemodel` files can be used by ROS nodes running on Jetson. The models can be used either in a [simulator environment](./Testing-in-Simulator) or on a [real drone](./Launch-Sequence-and-Flying).

# Pre-trained models
You can also use pre-trained models as described in [here](./pretrained/Pretrained-models.md). AriadneNet is our trained model based on the TrailNet architecture.

# Network Architectures (TrailNet)
The architecture used for our trail following DNN, the AriadneNet, is based on TrailNet. More information can be found [here](./nets/Nets.md).
