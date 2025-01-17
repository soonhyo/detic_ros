#! /bin/sh

# docker run --rm --net=host -it detic_ros:latest \
#     /bin/bash

docker run --rm --net=host -it detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster 133.11.216.225; \
    roslaunch detic_ros sample_detection.launch \
    debug:=true \
    compressed:=true \
    vocabulary:=custom\
    custom_vocabulary:=box\
    input_image:=/hsrb/hand_camera/color/image_rect_color \
    input_depth:=/hsrb/hand_camera/aligned_depth_to_color/image_raw \
    input_camera_info:=/hsrb/hand_camera/aligned_depth_to_color/camera_info'
    # input_image:=/hsrb/head_rgbd_sensor/rgb/image_rect_color

    # input_depth:=/hsrb/head_rgbd_sensor/depth_registered/image_rect_raw \
    # input_camera_info:=/hsrb/head_rgbd_sensor/depth_registered/camera_info'

