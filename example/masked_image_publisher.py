#!/usr/bin/env python3
import copy
import cv2

import message_filters
import numpy as np
import rospy

from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from std_msgs.msg import String
from detic_ros.msg import SegmentationInfo


class SampleNode:

    def __init__(self):
        sub_image = message_filters.Subscriber(rospy.get_param('~in_image', "/hsrb/hand_camera/color/image_rect_color"), Image)
        sub_info = message_filters.Subscriber(rospy.get_param('~seginfo', "/docker/detic_segmentor/segmentation_info"), SegmentationInfo)
        sub_list = [sub_image, sub_info]
        ts = message_filters.ApproximateTimeSynchronizer(sub_list, 100, 10.0)
        ts.registerCallback(self.callback)

        self.pub = rospy.Publisher(rospy.get_param('~out_image'), Image,
                                   queue_size=1)

    def callback(self, msg_image, msg_info: SegmentationInfo):
        rospy.loginfo('rec messages')
        class_name = rospy.get_param('~masked_image')

        # find label number corresponding to desired object class name
        try:
            label_index = msg_info.detected_classes.index(class_name)
            confidence_score = msg_info.scores[label_index]
            rospy.loginfo('specified object class {} is detected with score {}'.format(
                class_name, confidence_score))
        except ValueError:
            rospy.logdebug('class not found: {}'.format(class_name))
            return

        seg = msg_info.segmentation
        assert msg_image.width == seg.width
        assert msg_image.height == seg.height
        bridge = CvBridge()
        img = bridge.imgmsg_to_cv2(msg_image, desired_encoding='passthrough')
        seg_img = bridge.imgmsg_to_cv2(seg, desired_encoding='passthrough')
        # Add 1 to label_index to account for the background

        print(seg_img.max())
        for i in range(seg_img.max()):
            mask_indexes = np.where(seg_img == i+1)
            ys, xs = mask_indexes
            if len(xs) == 0:
                continue
            x1 = xs.min()
            x2 = xs.max()
            y1 = ys.min()
            y2 = ys.max()
            # cv2.rectangle(img, (x1, y1), (x2, y2),
            #               (255, 0, 0),
            #               10, -1)



        msg_out = bridge.cv2_to_imgmsg(img, encoding="rgb8")
        self.pub.publish(msg_out)


if __name__ == '__main__':
    rospy.init_node('mask_image_publisher')
    SampleNode()
    rospy.spin()
