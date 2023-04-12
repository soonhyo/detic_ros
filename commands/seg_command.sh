#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster ; \
    roslaunch detic_ros sample_detection_seg.launch \
    debug:=true \
    confidence_threshold:=0.3\
    use_pca:=true\
    vocabulary:=custom \
    custom_vocabulary:="scissor,comb"\
    input_image:=/camera/color/image_raw\
    input_depth:=/camera/aligned_depth_to_color/image_raw\
    input_camera_info:=/camera/aligned_depth_to_color/camera_info'
