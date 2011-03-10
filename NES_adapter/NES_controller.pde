/*
NES controller adpater using Teensy.
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
  if(!digitalRead(dataPin)){
    Keyboard.set_key1(KEY_A);
  }else{
    Keyboard.set_key1(0);
  }
  pulse();
  if(!digitalRead(dataPin)){
    Keyboard.set_key2(KEY_B);
  }else{
    Keyboard.set_key2(0);
  }
  pulse();
  modifiers = 0;
  if(!digitalRead(dataPin))
    modifiers = MODIFIERKEY_CTRL;
  pulse();
  if(!digitalRead(dataPin))
    modifiers |= MODIFIERKEY_SHIFT;
  pulse();
  if(!digitalRead(dataPin)){
    Keyboard.set_key3(KEY_U);
  }else{
    Keyboard.set_key3(0);
  }
  pulse();
  if(!digitalRead(dataPin)){
    Keyboard.set_key4(KEY_D);
  }else{
    Keyboard.set_key4(0);
  }
  pulse();
  if(!digitalRead(dataPin)){
    Keyboard.set_key5(KEY_L);
  }else{
    Keyboard.set_key5(0);
  }
  pulse();
  if(!digitalRead(dataPin)){
    Keyboard.set_key6(KEY_R);
  }else{
    Keyboard.set_key6(0);
  }
  pulse();
  Keyboard.set_modifier(modifiers);
  Keyboard.send_now();
}
void pulse(){
  digitalWrite(pulsePin, HIGH);
  digitalWrite(pulsePin, LOW);
}
