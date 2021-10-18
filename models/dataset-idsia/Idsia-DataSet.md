# IDSIA Dataset (Switzerland)
The IDSIA [Forest Trails](http://people.idsia.ch/~giusti/forest/web/) dataset can be found as a [single archive](https://people.idsia.ch//~guzzi/DataSet.zip).
Note that it may need to be rebuild after downloading. We used "Repair" tool from WinRAR.

You should unzip it inside current folder `dataset-idsia`.
The `idsia_trails_dataset_digitsV3.py` script is used to create map files for the IDSIA dataset. As minimum requirement you need to have python version 3.x already installed.

The script creates 2 map files for training and validation datasets, that can be used to create a corresponding dataset in DIGITS.
For example, to create dataset map files (with oversampling for training set):
```
python idsia_trails_dataset_digitsV3.py /data/datasets/TrailDataset/ /data/trails/train_map.txt 200000 /data/trails/val_map.txt 50000 -s=oversample
```
OR
```
<ws-parent-folder-path>/autonomous_drones/models/dataset-idsia/DataSet/ <ws-parent-folder-path>/autonomous_drones/models/dataset-idsia/trails/train_map.txt 200000 <ws-parent-folder-path>/autonomous_drones/models/dataset-idsia/trails/val_map.txt 50000 -s=oversample

```
Run `python idsia_trails_dataset_digitsV3.py -h` to get more information on script arguments.

