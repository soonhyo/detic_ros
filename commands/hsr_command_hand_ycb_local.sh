#! /bin/bash
docker run --rm --net=host -it --gpus 1 detic_ros:clip \
    /bin/bash -i -c \
    'source ~/.bashrc; \
    rossetip; rossetmaster localhost; \
    roslaunch detic_ros sample_detection_m.launch \
    debug:=true \
    masked_image:="baseball"\
    confidence_threshold:=0.1\
    use_pca:=true\
    vocabulary:=custom \
    custom_vocabulary:="a photo of a pringles can,a photo of a blue coffee can,a photo of a box of cheez-it,a photo of a yellow box of Domino sugar,a photo of a can of campbells tomato soup,a photo of a yellow mustard,a photo of a StarKist can tuna,a photo of a box of brown chocolate pudding jello,a photo of a box of red jello,a photo of a can of spam,a photo of a banana which is a type of fruit,a photo of a red strawberry with green stem which is a type of fruit,a photo of a red apple, a type of fruit,a photo of a lemon which is a type of fruit,a photo of a yellowish peach which is a type of fruit,a photo of a green pear which is a type of fruit,a photo of a orange which is a type of fruit,a photo of a purple plum which is a type of fruit,a photo of a blue pitcher,a photo of a pitcher lid,a photo of a soft scrub bleach bottle,a photo of a windex spray bottle,a photo of a wine glass,bowl a photo of a red bowl,a photo of a red mug, a photo of a sponge,a photo of a plate,a photo of a red fork,a photo of a red spoon,a photo of a spatula,a photo of a key,a photo of a expo marker,a photo of a expo marker,a photo of a bolt,a photo of a clamp,a photo of a card,baseball,a photo of a rope,a photo of a chain,a photo of a brick,a photo of a die,a photo of a marble,cup,a photo of a wooden puzzle,a photo of a toy airplane,a photo of a time magazine,a photo of a black t-shirt,a photo of a lego,a photo of a timer,a photo of a rubiks cube" \
    input_image:=/hsrb/hand_camera/color/image_rect_color\
    input_depth:=/hsrb/hand_camera/aligned_depth_to_color/image_raw\
    input_camera_info:=/hsrb/hand_camera/aligned_depth_to_color/camera_info'
         # custom_vocabulary:="chips can, coffee can, cracker box, box of sugar, tomato soup can, mustard container, tuna fısh can, chocolate pudding box, gelatin box, potted meat can, lemon, apple, pear, orange, banana, peach, strawberries, plum, pitcher, bleach cleanser, glass cleaner, plastic wine glass, enamel-coated metal bowl, metal mug, abrasive sponge, cooking skillet with glass lid, metal plate, knife, spoon, fork, spatula, white table cloth, a power drill and wood block, middle row, scissors, a padlock and keys, markers, an adjustable wrench, Phillips- and flat-head screwdrivers, wood screws, nails, plastic bolts and nuts, and a hammer, spring clamps, mini soccer ball, softball, baseball, tennis ball, racquetball, golf ball, plastic chain, washers, foam brick, dice, marbles, rope, stacking blocks, credit card blank, Box and blocks test, 9 hole peg test, timer, Lego Dublo, magazine, Rubick’s cube, t-shirt, airplane toy" \
