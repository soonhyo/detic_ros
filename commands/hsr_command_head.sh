#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster 133.11.216.222; \
    roslaunch detic_ros sample_detection.launch \
    debug:=true \
    confidence_threshold:=0.3\
    use_pca:=true\
    vocabulary:=custom \
    custom_vocabulary:="the photo of a pen" \
    input_image:=/hsrb/head_rgbd_sensor/rgb/image_raw\
    input_depth:=/hsrb/head_rgbd_sensor/depth_registered/image\
    input_camera_info:=/hsrb/head_rgbd_sensor/depth_registered/camera_info'
