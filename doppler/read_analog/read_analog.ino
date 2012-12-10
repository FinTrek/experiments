
const int ledPin = 9;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  int sensorValue = analogRead(A0);
  float inByte = float(sensorValue); 
  inByte = map(inByte, 0, 1023, 0, 255);
  Serial.println(sensorValue);
  analogWrite(ledPin, inByte);
}
