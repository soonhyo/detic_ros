#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from std_msgs.msg import String
from cv_bridge import CvBridge
import cv2
import clip
import torch
import torch.nn as nn
from PIL import Image as PImage
import numpy as np

class Linear(nn.Module):
    def __init__(self,input_size, output_size):
        super().__init__()
        self.fc1 = nn.Linear(input_size, output_size)

    def forward(self, x):
        x = self.fc1(x)
        return x

class ClipLinearProbe(object):
    def __init__(self):
        super().__init__()
        #device = "cuda" if torch.cuda.is_available() else "cpu"
        self.device = "cpu"
        self.clip_model, self.preprocess = clip.load('ViT-B/32', self.device)
        self.bridge = CvBridge()
        self.linear_model= torch.load("model/best_model.pth")
        self.linear_model.to(self.device)
        self.linear_model.eval()
        self.pub = rospy.Publisher("~output", String, queue_size=1)
        # Subscribe to the image topic
        rospy.Subscriber("/docker/detic_segmentor/instance_segmented_image", Image, self.image_callback)

    def cv2pil(self, image):
        new_image = image.copy()
        if new_image.ndim == 2:
            pass
        elif new_image.shape[2] == 3:
            new_image = cv2.cvtColor(new_image, cv2.COLOR_BGR2RGB)
        elif new_image.shape[2] == 4:
            new_image = cv2.cvtColor(new_image, cv2.COLOR_BGRA2RGBA)
        new_image = PImage.fromarray(new_image)
        return new_image


    def image_callback(self, msg):

        # Convert ROS Image message to OpenCV format
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
        image = self.cv2pil(cv_image)

        with torch.no_grad():
            image = self.preprocess(image)
            feature = self.clip_model.encode_image(image.unsqueeze(0).to(self.device))
            y = self.linear_model(feature.to(torch.float32))
            pred = torch.argmax(y)
            pred_msg = String()
            pred_msg.data = str(pred)
            self.pub.publish(pred_msg)

def main():
    rospy.init_node('image_subscriber')
    app =ClipLinearProbe()
    # Start the main loop
    rospy.spin()

if __name__ == '__main__':
    main()
