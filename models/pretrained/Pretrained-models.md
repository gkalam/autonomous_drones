# AriadneNet model
`AriadneNet_SResNet-18` model is a ready-to-use model that was trained using method described in the [thesis](../../docs/mscThesis_gkalam.pdf). The architecture used for AriadneNet is based upon TrailNet described in [this paper](https://arxiv.org/abs/1705.02550).

# YOLO model
The original model was split into 3 files using the following command:
```
split -b 100m -d yolo-relu.caffemodel yolo-relu.caffemodel.
```
GitHub has a limit of 100MB for a single file.

To obtain the original file, run the following command:
```
cat yolo-relu.caffemodel.* > yolo-relu.caffemodel
```
