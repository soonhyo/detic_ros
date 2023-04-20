#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from detic_ros.msg import SegmentationInfo
from cv_bridge import CvBridge
import cv2
import numpy as np


class ImageSubscriber:
    def __init__(self):
        # Initialize the ROS node
        rospy.init_node('target_segmentation')

        # Subscribe to the image topic
        rospy.Subscriber("~in_seginfo", SegmentationInfo, self.image_callback)
        # rospy.Subscriber("~in_labels", LabelArray, self.classes_callback)

        # Create a publisher for the segmented image topic
        self.seg_pub = rospy.Publisher("~output", Image, queue_size=10)
        self.debug_pub = rospy.Publisher("~debug", Image, queue_size=10)

        # Initialize the CvBridge
        self.bridge = CvBridge()
        # Set the default target class name
        self.target= rospy.get_param("/target", "scissor")
        self.target_id = -1

    def image_callback(self, msg):
        self.target= rospy.get_param("/target", "scissor")

        classes=msg.detected_classes
        frame_id=msg.header.frame_id
        self.target_id = -1

        for idx, cl in enumerate(classes):
            if self.target == cl:
                self.target_id = idx+1
        print(self.target_id)
        
        img = self.bridge.imgmsg_to_cv2(msg.segmentation, "32SC1")
        seg_img = np.where(img == self.target_id, 1, 0).astype(np.int32)
        debug_img = seg_img.astype(np.uint8)*255
        
        seg_msg = self.bridge.cv2_to_imgmsg(seg_img, encoding="32SC1")
        debug_msg = self.bridge.cv2_to_imgmsg(debug_img, encoding="mono8")

        seg_msg.header.frame_id = frame_id
        seg_msg.header.stamp = rospy.Time.now()

        debug_msg.header.frame_id = frame_id
        debug_msg.header.stamp = rospy.Time.now()
        
        self.seg_pub.publish(seg_msg)
        self.debug_pub.publish(debug_msg)

    def run(self):
        # Start the main loop
        rospy.spin()

        # Close the window
        cv2.destroyAllWindows()

if __name__ == '__main__':
    node = ImageSubscriber()
    node.run()
