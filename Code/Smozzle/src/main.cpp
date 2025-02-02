#include <Arduino.h>
#include <Timer.h>

#define leftInPin 4
#define leftOutPin 6
#define rightInPin 9
#define rightOutPin 10

#define leftPressurePin 0
#define rightPressurePin 1
#define tolerance 4

void setSolenoidState(bool, bool, bool, bool);
void getPressures();
void setTargets(int, int);
void updateSolenoidControl();
void printTelemetry();

bool solenoidStates[4];

int leftTarget;
int rightTarget;
int leftPressure;
int rightPressure;

Timer timer(MILLIS);

enum SmozzleState {
  IDLE,
  STEP1,
  STEP2,
  STEP3
};

SmozzleState smozzleState = SmozzleState::IDLE;

void setup() {
  Serial.begin(9600);

  pinMode(leftInPin, OUTPUT);
  pinMode(leftOutPin, OUTPUT);
  pinMode(rightInPin, OUTPUT);
  pinMode(rightOutPin, OUTPUT);
  setSolenoidState(0, 0, 0, 0);

  getPressures();
  setTargets(35, 15);
  smozzleState = SmozzleState::STEP1;
  timer.start();
}

void loop() {
  
  switch (smozzleState) {
  case SmozzleState::STEP1:
    if (timer.read() > 5000) {
      timer.stop();
      setTargets(35, 35);
      smozzleState = SmozzleState::STEP2;
      timer.start();
    }
    break;

  case SmozzleState::STEP2:
    if (timer.read() > 5000) {
      timer.stop();
      setTargets(15, 35);
      smozzleState = SmozzleState::STEP3;
      timer.start();
    }
    break;

  case SmozzleState::STEP3:
    if (timer.read() > 5000) {
      timer.stop();
      setTargets(15, 15);
      smozzleState = SmozzleState::IDLE;
      timer.start();
    }
    break;

  case SmozzleState::IDLE:
    
    break;
  
  default:
    smozzleState = SmozzleState::IDLE;
    break;
  }

  getPressures();
  updateSolenoidControl();
  printTelemetry();
}

void setSolenoidState(bool leftInState, bool leftOutState, bool rightInState, bool rightOutState) {
  solenoidStates[0] = leftInState;
  solenoidStates[1] = leftOutState;
  solenoidStates[2] = rightInState;
  solenoidStates[3] = rightOutState;
  digitalWrite(leftInPin, leftInState);
  digitalWrite(leftOutPin, leftOutState);
  digitalWrite(rightInPin, rightInState);
  digitalWrite(rightOutPin, rightOutState);
}

void getPressures() {
  leftPressure = analogRead(leftPressurePin);
  rightPressure = analogRead(rightPressurePin);
}

void setTargets(int LT, int RT) {
  leftTarget = LT;
  rightTarget = RT;
}

void updateSolenoidControl() {
  bool LIS = 0;
  bool LOS = 0;
  bool RIS = 0;
  bool ROS = 0;

  if (leftPressure < (leftTarget-tolerance)) {
    LIS = 1;
    LOS = 0;
  } else if (leftPressure > (leftTarget+tolerance)) {
    LIS = 0;
    LOS = 1;
  } else {
    LIS = 0;
    LOS = 0;
  }

  if (rightPressure < (rightTarget-tolerance)) {
    RIS = 1;
    ROS = 0;
  } else if (rightPressure > (rightTarget+tolerance)) {
    RIS = 0;
    ROS = 1;
  } else {
    RIS = 0;
    ROS = 0;
  }

  setSolenoidState(LIS, LOS, RIS, ROS);
}

void printTelemetry() {
  Serial.print("Target Pressures:");
  Serial.print("Left Target Pressure: ");
  Serial.print(leftTarget);
  Serial.print(" Right Target Pressure: ");
  Serial.print(rightTarget);

  Serial.print(" Current Pressures:");
  Serial.print("Left Pressure: ");
  Serial.print(leftPressure);
  Serial.print(" Right Pressure: ");
  Serial.print(rightPressure);

  Serial.print(" Solenoid States:");
  Serial.print("Left In: ");
  Serial.print(solenoidStates[0]);
  Serial.print(" Left Out: ");
  Serial.print(solenoidStates[1]);
  Serial.print(" Right In: ");
  Serial.print(solenoidStates[2]);
  Serial.print(" Right Out: ");
  Serial.println(solenoidStates[3]);
}