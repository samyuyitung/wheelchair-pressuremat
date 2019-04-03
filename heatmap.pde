import processing.serial.*;
Serial port;

int NUM = 4;
final color MIN_COLOR = color(255, 255, 255);
final color MAX_COLOR = color(255, 0, 0);

void setup() {
  size(500, 500);
  frameRate(60);
  port = new Serial(this, "/dev/cu.usbmodem14401", 9600);
  port.bufferUntil('\n');
}

void draw() {
  int[][] data = fetchData();
  if (data != null) {
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data.length; j++) {
        fill(lerpColor(MIN_COLOR, MAX_COLOR, data[i][j] / 1023.0));
        rect(i * width / NUM, j * height / NUM, width / NUM, height / NUM);
      }
    }
  }
}


int[][] fetchData() {
  String serial = fetchFromSerial();
  if (serial != null) {
    int[][] data = new int[4][4];
    String[] rows = split(serial, ';');
    for (int i = 0; i < rows.length; i++) {
      String[] cols = split(rows[i], ',');
      for (int j = 0; j < cols.length; j++) {
        data[i][j] = int(cols[j]);
      }
    }
    
    return data;
  }
  return null;
}

String fetchFromSerial() {
  return port.readStringUntil('\n');
}
