# Our Dataset (Zografou University Campus)
> **Due to size limitations, this dataset is only available through a set of 3 DVDs. Total Size: 10+GB**

Folders 000..005 contain the dataset used to train the networks. Folder `calib` contains preliminary test data (calibration). Folders 006..008 contain data for testing the system.

In each numbered folder, there is a `videos` sub-folder, containing left-camera(lc), straight-camera(sc) and right-camera(rc) sub-folders. Each of these contains the videos recorded in .avi format.
- `info.txt` contains some description characteristics for each recording trip.
- `script.sh` is used for automating the pre-processing of our footage:
--	`videoParserV3.py` splits videos into frames and
--	`frameSplitterV3.py` undistorts image frames and then splits them into three virtual views of 60 degrees

All you need to do is: 
i. copy `videoParserV3.py` and `frameSplitterV3.py` from directory `autonomous_drones/tools/camera_rig` to each numbered sub-folder
ii. copy `calibration.2M.yml` extracted from `widecam_mono_calibration` to each numbered sub-folder
iii. run from terminal `bash ./script.sh` in each numbered sub-folder

For calibration, you need to `cd` in folder `calib`, then run:

``widecam_mono_calibration -input=<path calibration target images> -results=<path to results>``
OR
``widecam_mono_calibration -input=./calib.frames.2M/ -results=./calib.frames.2M.results/``

The camera calibration application stores the intrinsic parameters in a calibration file (in YML format) and also saves out undistorted images of the calibration target.

