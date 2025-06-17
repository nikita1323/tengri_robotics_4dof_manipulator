#!/usr/bin/env python

import rospy


from sensor_msgs.msg import JointState
from rospy_tutorials.msg import Floats
import math

def cb(msg):
    x=Floats()
    x.data.append(90+math.degrees(msg.position[0]))
    x.data.append(90+math.degrees(msg.position[1]))
    x.data.append(90+math.degrees(msg.position[2]))
    x.data.append(90+math.degrees(msg.position[3]))

    pub.publish(x)

    del x
    


rospy.init_node('Joints_to_aurdino')

pub = rospy.Publisher('/joints_to_arduino', Floats, queue_size=100)

sub = rospy.Subscriber('/joint_states', JointState, cb, queue_size=100)


rospy.spin()

