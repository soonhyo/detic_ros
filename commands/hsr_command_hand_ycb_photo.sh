#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:latest \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster 133.11.216.222; \
    roslaunch detic_ros sample_detection.launch \
    debug:=true \
    confidence_threshold:=0.7\
    use_pca:=true\
    vocabulary:=custom \
    custom_vocabulary:="a photo of a chips can,a photo of a coffee can,a photo of a cracker box,a photo of a box of sugar,a photo of a tomato soup can,a photo of a mustard container,a photo of a tuna fısh can,a photo of a chocolate pudding box,a photo of a gelatin box,a photo of a potted meat can,a photo of a lemon,a photo of a apple,a photo of a pear,a photo of a orange,a photo of a banana,a photo of a peach,a photo of a strawberries,a photo of a plum,a photo of a pitcher,a photo of a bleach cleanser,a photo of a glass cleaner,a photo of a plastic wine glass,a photo of a enamel-coated metal bowl,a photo of a metal mug,a photo of a abrasive sponge,a photo of a cooking skillet with glass lid,a photo of a metal plate,a photo of a knife,a photo of a spoon,a photo of a fork,a photo of a spatula,a photo of a white table cloth,a photo of a a power drill and wood block,a photo of a middle row,a photo of a scissors,a photo of a a padlock and keys,a photo of a markers,a photo of a an adjustable wrench,a photo of a Phillips- and flat-head screwdrivers,a photo of a wood screws,a photo of a nails,a photo of a plastic bolts and nuts,a photo of a and a hammer,a photo of a spring clamps,a photo of a mini soccer ball,a photo of a softball,a photo of a baseball,a photo of a tennis ball,a photo of a racquetball,a photo of a golf ball,a photo of a plastic chain,a photo of a washers,a photo of a foam brick,a photo of a dice,a photo of a marbles,a photo of a rope,a photo of a stacking blocks,a photo of a credit card blank,a photo of a Box and blocks test,a photo of a 9 hole peg test,a photo of a timer,a photo of a Lego Dublo,a photo of a magazine,a photo of a Rubick’s cube,a photo of a t-shirt,a photo of a airplane toy" \
    input_image:=/hsrb/hand_camera/color/image_rect_color\
    input_depth:=/hsrb/hand_camera/aligned_depth_to_color/image_raw\
    input_camera_info:=/hsrb/hand_camera/aligned_depth_to_color/camera_info'
