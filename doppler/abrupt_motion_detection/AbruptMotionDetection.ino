
const int ledPin = 9;
const int value_length = 100;
int values[value_length];

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  int sensorValue = analogRead(A0);
  int freq = frequency_estimation(sensorValue);
  Serial.println(freq);
  float inByte = float(freq); 
  inByte = map(inByte, 0, 45, 0, 255);
  analogWrite(ledPin, inByte);
}

int frequency_estimation(int sensorValue) {
  int cycles = 0;
  for (int i=0; i<value_length-1; i++) {
    if(signal_floor(values[i]) != signal_floor(values[i+1]))
      cycles++;
    values[i] = values[i+1];
  }
  values[value_length-1] = sensorValue;
  return cycles;
}

boolean signal_floor(int sensorValue) {
  return sensorValue > 600;
}
  
