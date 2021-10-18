# Dataset preparation
This directory contains our camera rig calibration application and scripts that are used to create datasets:

`autonomous_drones/tools/camera_rig`

To collect data and autolabel it, we used a simple 3 camera rig with Full HD cameras.

The cameras are mounted on a pole (ours was 1.10m in length) with one camera clamped securely on the left side, one clamped in the middle, and one on the right side. The video recording rig is then walked along the middle of the path, trail, or other channel you wish to capture. Each camera collects a different view into the environment, so the TrailFollowing DNN can learn to classify drone's rotation on the trail as well as its lateral position relative to the center of the trail. The DNN produces probabilities of the drone turned 25-35 degrees to the left, right, or looking straight as well as probabilities of the drone being on the left side, right side, or middle of a trail. We recommend recording data with 120 degrees field of view lenses, running at 30 frames per second, and then sampling frames every 1 second (i.e. every 30 frames).

The use of wide angle lenses lead to fisheye distortions in recorded frames, which may not be too different from typical 60 degrees field of view cameras used on drones. However, we provide a camera calibration application that allows to calibrate intrinsic parameters of each camera rig camera individually. The resulting calibrations can be used by video parsing scripts to undistort the recorded dataset frames to make them rectilinear (i.e. remove the fisheye distortions). The camera calibration application is located in this directory:

`autonomous_drones/tools/camera_rig/widecam_mono_calibration/`
 
It is a C++ application that uses OpenCV4.0 and should be built on your host computer. Once built, record several distinct images (up to 20-30) of a calibration target with your cameras and then use those images with the calibration application to compute intrinsic camera parameters. We included a chessboard calibration target in this file:

`autonomous_drones/tools/camera_rig/widecam_mono_calibration/chessboard_100mm.pdf`

You can display it on a computer screen (or print it out and attach it to a flat surface) and record several images (we recommend 20-30) with your cameras. For best results, we recommend recording a video from different points of view covering big enough 3D volume around the calibration target, then splitting the recorded video into frames with the provided python script, and then selecting best frames (that are sharp and show the whole target). Once you have a set of calibration target photos, you can run calibration by running the application as follows:

``widecam_mono_calibration -input=<path calibration target images> -results=<path to results>``

The camera calibration application stores the intrinsic parameters in a calibration file (in YML format) and also saves out undistorted images of the calibration target. Make sure that the straight lines are straight on those images before trusting the calibration parameters.

We also provide a convenient python script for splitting videos into individual frames that can be used during  calibration and for dataset videos parsing. This script is located here:

`autonomous_drones/tools/camera_rig/videoParserV3.py`

and can be run as:

`videoParserV3.py <inputVideoFile> <outputDir> [-p|--prefix outFrameNamePrefix] [-c|--skipcount inputFrameSkipCount] [-e|--ext outFrameExtension]`

Once you have calibrated your cameras and have YML files containing the intrinsic parameters, you can run this script:

`autonomous_drones/tools/camera_rig/frameSplitterV3.py`

to undistort recorded frames and to split each 120 degrees frame into three 60 degrees virtual views that look 25 degrees left, straight and 25 degrees right. The script takes a calibration YML file and individual frames and outputs undistorted and split virtual views. You can run it as:

`frameSplitterV3.py <inputDir> <outputDir> <calibration> [-g|--grayscale] [-e|--ext IMAGE_FILE_EXTENSION]`

The generated virtual views can then be used for training the TrailFollowing DNN. You can use either all of them for training rotation+translation from scratch or only some of them for fine-tuning a pre-trained model. For example, only straight views can be used to trail the lateral translation head.

