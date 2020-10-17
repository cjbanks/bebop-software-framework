#!/usr/bin/env python3

import rospy
from bebop_experiments.msg import mtrspeeds
import telnetlib
import re

HOST = "192.168.42.1"
I2C_MTR_CTR_ADDR = 0x08

class ReadMotorSpeeds(object):
    def __init__(self):
        self.mtr_speed_pub = rospy.Publisher("motor_speeds", mtrspeeds, queue_size=1)
        self.address = I2C_MTR_CTR_ADDR
        self.old_mtr_speeds = mtrspeeds()
        self.rate = rospy.Rate(10)
        self.bebop_sesh = None
        # ssh into bebop
        # while not rospy.is_shutdown() and self.bebop_sesh is None:
        try:
            rospy.loginfo("connecting...")
            self.bebop_sesh = telnetlib.Telnet(HOST)
            rospy.loginfo("connected!")
        except (OSError, ConnectionRefusedError):
            rospy.logwarn("cant run client")
            rospy.logwarn("reconnect..")
        else:
            rospy.loginfo("success!")
            self.bebop_sesh.close()




    def read_motor_data(self):
        # read all bebop data from motor controller
        # print("reading motor data")
        all_motor_speeds = mtrspeeds()
        while not rospy.is_shutdown():
           try:
            self.bebop_sesh = telnetlib.Telnet(HOST)
            # rospy.sleep(0.02)
            self.bebop_sesh.write(b"i2ctool -d /dev/i2c-1 -n 15 0x08 0x20\n")
            # data = self.bebop_sesh.read_until(b"\n")
            # rospy.sleep(0.02)
            data = self.bebop_sesh.read_until(b"reading")
            # data = self.bebop_sesh.read_until(b"\n")
            coherent_data = self.bytes_2_rpm(data)
            all_motor_speeds.m_1 = coherent_data[0]
            all_motor_speeds.m_2 = coherent_data[1]
            all_motor_speeds.m_3 = coherent_data[2]
            all_motor_speeds.m_4 = coherent_data[3]
            self.mtr_speed_pub.publish(all_motor_speeds)
            self.old_mtr_speeds = all_motor_speeds
           except Exception:
               self.bebop_sesh.close()
               rospy.logwarn("AN EXCEPTION was thrown")
               self.mtr_speed_pub.publish(self.old_mtr_speeds)
               # rospy.sleep(0.02)
               self.rate.sleep()
           else:
               self.bebop_sesh.close()
               self.mtr_speed_pub.publish(self.old_mtr_speeds)
               rospy.loginfo("Leaving connection")
               # rospy.sleep(0.02)
               self.rate.sleep()
        else:
            self.bebop_sesh.close()

    def bytes_2_rpm(self, bytes):
        arr = []
        #data = bytes.decode('ascii')
        #print("raw data: ", data)
        #data = re.sub("\r\n", "", data)
        #print("new data: ", data)
        # split_data = re.split(' ', data)

        data = self.bebop_sesh.read_until(b"\n")
        #print("other data: ", data.decode('ascii'))
        split_data = re.split(' ', data.decode('ascii'))

        # print("split data: ", split_data)


        if split_data[1] == '0x08-0x20:':
            rospy.loginfo("RECIEVED GOOD INFO -- return motor speeds")
            # print("val in int: ", int(split_data[-1], 16))
            split_data_n = split_data[3::]
            buffer_rpm = []
            print("n: ", split_data_n)
            for item in split_data_n:
                buffer_rpm.append(int(item, 0))

            print("buffer: ", buffer_rpm)
            arr.append(((buffer_rpm[1] | (buffer_rpm[0] << 8)) & ~(1 << 15)))
            arr.append(((buffer_rpm[3] | (buffer_rpm[2] << 8)) & ~(1 << 15)))
            arr.append(((buffer_rpm[5] | (buffer_rpm[4] << 8)) & ~(1 << 15)))
            arr.append(((buffer_rpm[7] | (buffer_rpm[6] << 8)) & ~(1 << 15)))
            print("rpm: ", arr)
            return arr
        else:
            return AssertionError

if __name__ == "__main__":
    motor_speed_node = rospy.init_node("motor_speed_node", anonymous=True)
    mtrSpeedReader = ReadMotorSpeeds()
    while mtrSpeedReader.bebop_sesh is None and rospy.is_shutdown() is False:
        mtrSpeedReader = ReadMotorSpeeds()
        if rospy.is_shutdown():
            break
    mtrSpeedReader.read_motor_data()
    rospy.spin()






