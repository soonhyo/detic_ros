#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster 133.11.216.222; \
    roslaunch detic_ros sample_detection.launch \
    debug:=true \
    confidence_threshold:=0.3\
    use_pca:=true\
    vocabulary:=lvis \
    input_image:=/hsrb/hand_camera/color/image_raw\
    input_depth:=/hsrb/hand_camera/aligned_depth_to_color/image_raw\
    input_camera_info:=/hsrb/hand_camera/aligned_depth_to_color/camera_info'
