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
    custom_vocabulary:="chips can, coffee can, cracker box, box of sugar, tomato soup can, mustard container, tuna fısh can, chocolate pudding box, gelatin box, potted meat can, lemon, apple, pear, orange, banana, peach, strawberries, plum, pitcher, bleach cleanser, glass cleaner, plastic wine glass, enamel-coated metal bowl, metal mug, abrasive sponge, cooking skillet with glass lid, metal plate, knife, spoon, fork, spatula, white table cloth, a power drill and wood block, middle row, scissors, a padlock and keys, markers, an adjustable wrench, Phillips- and flat-head screwdrivers, wood screws, nails, plastic bolts and nuts, and a hammer, spring clamps, mini soccer ball, softball, baseball, tennis ball, racquetball, golf ball, plastic chain, washers, foam brick, dice, marbles, rope, stacking blocks, credit card blank, Box and blocks test, 9 hole peg test, timer, Lego Dublo, magazine, Rubick’s cube, t-shirt, airplane toy" \
    input_image:=/hsrb/head_rgbd_sensor/rgb/image_raw\
    input_depth:=/hsrb/head_rgbd_sensor/depth_registered/image\
    input_camera_info:=/hsrb/head_rgbd_sensor/depth_registered/camera_info'
