#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster baxter; \
    roslaunch detic_ros sample_detection.launch \
    debug:=true \
    confidence_threshold:=0.3\
    use_pca:=true\
    vocabulary:=custom\
    custom_vocabulary:="scissor,comb"\
    input_image:=/camera1/color/image_raw\
    input_depth:=/camera1/aligned_depth_to_color/image_raw\
    input_camera_info:=/camera1/aligned_depth_to_color/camera_info'
