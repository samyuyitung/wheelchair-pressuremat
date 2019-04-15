#define ANALOG_PIN_1 A0
#define ANALOG_PIN_2 A1

#define CHARGE_PIN 13
#define DISCHARGE_PIN 11

#define MUX_CTRL_A 2
#define MUX_CTRL_B 3
#define MUX_CTRL_C 4

#define RESISTOR 1000000.0F

unsigned long startTime;
unsigned long elapsedTime;
long capacitance;

void setup() {
  pinMode(MUX_CTRL_A, OUTPUT);
  pinMode(MUX_CTRL_B, OUTPUT);
  pinMode(MUX_CTRL_C, OUTPUT);
  pinMode(CHARGE_PIN, OUTPUT);
  
  digitalWrite(CHARGE_PIN, LOW);
  Serial.begin(9600);
}

void loop() {
  samplePin(ANALOG_PIN_1);
  
  Serial.print(";");
  
  samplePin(ANALOG_PIN_2);
  
  Serial.println();
}

void sampleMux(int pin) {
  for (int i = 0; i < 8; i++) {
    writeControl(i);
    Serial.print(measureCapacitance(pin));
    if (i == 3) {
      Serial.print(";");
    } else if (i < 7) {
      Serial.print(",");
    }
  }
}

int measureCapacitance(int analogPin) {
  digitalWrite(CHARGE_PIN, LOW);
  pinMode(DISCHARGE_PIN, OUTPUT);
  digitalWrite(DISCHARGE_PIN, LOW);
  while (analogRead(analogPin) > 0) { /* nothing */ }

  pinMode(DISCHARGE_PIN, INPUT);

  startTime = micros();
  digitalWrite(CHARGE_PIN, HIGH);
  while (analogRead(analogPin) < 648) { /* nothing */ }
  
  elapsedTime = micros() - startTime;
  return ((float)elapsedTime / RESISTOR) * 1000000.0;
}

void writeControl(int input) {
  digitalWrite(MUX_CTRL_A, HIGH && (input & B00000001));
  digitalWrite(MUX_CTRL_B, HIGH && (input & B00000010));
  digitalWrite(MUX_CTRL_C, HIGH && (input & B00000100));
}

