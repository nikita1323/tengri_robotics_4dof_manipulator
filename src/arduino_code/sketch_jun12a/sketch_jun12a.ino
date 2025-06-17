#include <ros.h>
#include <rospy_tutorials/Floats.h>
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

// called this way, it uses the default address 0x40
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

#define SERVOMIN1  180 // This is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX1  420 // This is the 'maximum' pulse length count (out of 4096)
#define SERVOMIN2  90 // This is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX2  330 // This is the 'maximum' pulse length count (out of 4096)
#define SERVOMIN3  105 // This is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX3  340 // This is the 'maximum' pulse length count (out of 4096)
#define SERVOMIN4  95 // This is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX4  330 // This is the 'maximum' pulse length count (out of 4096)

#define SERVO_FREQ 50 // Analog servos run at ~50 Hz updates

void servo_cb( const rospy_tutorials::Floats& cmd_msg);

ros::NodeHandle  nh;
ros::Subscriber<rospy_tutorials::Floats> sub("/joints_to_arduino", servo_cb);

long int curTime, prevTime = 0;

void setup() {
  // put your setup code here, to run once:
  nh.initNode();
  nh.subscribe(sub);

  Serial.begin(57600);

  pwm.begin();

//  pwm.setOscillatorFrequency(27000000);
  pwm.setPWMFreq(SERVO_FREQ);  // Analog servos run at ~50 Hz updates

  delay(10);

}

void loop() {
  // put your main code here, to run repeatedly:
  curTime = millis();
  nh.spinOnce();
}

void servo_cb( const rospy_tutorials::Floats& cmd_msg){
  if (curTime - prevTime > 50){
    prevTime += 50;
    int tmp1 = map((int)cmd_msg.data[0], 180, 0, SERVOMIN1, SERVOMAX1);
    int tmp2 = map((int)cmd_msg.data[1], 0, 180, SERVOMIN2, SERVOMAX2);
    int tmp3 = map((int)cmd_msg.data[2], 0, 180, SERVOMIN3, SERVOMAX3);
    int tmp4 = map((int)cmd_msg.data[3], 0, 180, SERVOMIN4, SERVOMAX4);
  
    pwm.setPWM(15, 0, tmp1);
    pwm.setPWM(12, 0, tmp2);
    pwm.setPWM( 7, 0, tmp3);
    pwm.setPWM( 6, 0, tmp4);
  }
}
