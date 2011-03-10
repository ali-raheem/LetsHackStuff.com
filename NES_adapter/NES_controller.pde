/*
Title: NES controller adpater using Teensy.
Date: 10-03-2011
Author: Ali Raheem
*/
int pulsePin = PIN_D0;
int latchPin = PIN_D1;
int dataPin = PIN_D2;
int modifiers;
void setup(){
  pinMode(pulsePin, OUTPUT);
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin,  INPUT);
}
void loop(){
  digitalWrite(latchPin, HIGH);
  digitalWrite(latchPin, LOW);
  Keyboard.set_key1((digitalRead(dataPin))?0:KEY_A);
  pulse();
  Keyboard.set_key2((digitalRead(dataPin))?0:KEY_B);
  pulse();
  modifiers = 0;
  if(!digitalRead(dataPin))
    modifiers = MODIFIERKEY_CTRL;
  pulse();
  if(!digitalRead(dataPin))
    modifiers |= MODIFIERKEY_SHIFT;
  pulse();
  Keyboard.set_key3((digitalRead(dataPin))?0:KEY_U);
  pulse();
  Keyboard.set_key4((digitalRead(dataPin))?0:KEY_D);
  pulse();
  Keyboard.set_key5((digitalRead(dataPin))?0:KEY_L);
  pulse();
  Keyboard.set_key6((digitalRead(dataPin))?0:KEY_R);
  pulse();
  Keyboard.set_modifier(modifiers);
  Keyboard.send_now();
}
void pulse(){
  digitalWrite(pulsePin, HIGH);
  digitalWrite(pulsePin, LOW);
}