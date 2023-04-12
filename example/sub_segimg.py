#!/usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
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

def cv2pil(image):
    new_image = image.copy()
    if new_image.ndim == 2:
        pass
    elif new_image.shape[2] == 3:
        new_image = cv2.cvtColor(new_image, cv2.COLOR_BGR2RGB)
    elif new_image.shape[2] == 4:
        new_image = cv2.cvtColor(new_image, cv2.COLOR_BGRA2RGBA)
    new_image = PImage.fromarray(new_image)
    return new_image

#device = "cuda" if torch.cuda.is_available() else "cpu"
device = "cpu"
clip_model, preprocess = clip.load('ViT-B/32', device)
bridge = CvBridge()
linear_model= torch.load("model/best_model.pth")
linear_model.to(device)
linear_model.eval()

def image_callback(msg):
    #clip_model, preprocess = clip.load('ViT-L/14', device)


    # Convert ROS Image message to OpenCV format
    cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")
    image = cv2pil(cv_image)

    with torch.no_grad():
        image = preprocess(image)
        feature = clip_model.encode_image(image.unsqueeze(0).to(device))
        y =linear_model(feature.to(torch.float32))
        print(torch.argmax(y))

    # # Display the frame in a window
    # cv2.imshow('frame', cv_image)
    # cv2.waitKey(1)



def main():
    rospy.init_node('image_subscriber')

    # Subscribe to the image topic
    rospy.Subscriber("/docker/detic_segmentor/instance_segmented_image", Image, image_callback)

    # Start the main loop
    rospy.spin()

    # Close the window
    # cv2.destroyAllWindows()

if __name__ == '__main__':
    main()
