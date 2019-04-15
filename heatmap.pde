import processing.serial.*;
Serial port;
int NUM = 4;
final color MIN_COLOR = color(255, 255, 255);
final color MAX_COLOR = color(255, 0, 0);

final int MIN_CAP = 200;
final int MAX_CAP = 400;

void setup() {
  size(500, 500);
  frameRate(60);
  port = new Serial(this, "/dev/cu.usbmodem14601", 9600);
  port.bufferUntil('\n');
}

void draw() {
  int[][] data = fetchData();

  if (data != null) {
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[0].length; j++) {
		float scaledCap = map(data[i][j], MIN_CAP, MAX_CAP, 0,1);
        fill(lerpColor(MIN_COLOR, MAX_COLOR, scaledCap);
        rect(i * width / NUM, j * height / NUM, width / NUM, height / NUM);
      }
    }
  }
}


int[][] fetchData() {
  String serial = fetchFromSerial();
  if (serial != null) {
    int[][] data = new int[NUM][NUM];

    String[] rows = split(serial, ';');

    if (rows.length == NUM) {
      for (int i = 0; i < rows.length; i++) {
        String[] cols = split(rows[i], ',');
        if (cols.length == NUM) {
          for (int j = 0; j < cols.length; j++) {
            data[i][j] = int(trim(cols[j]));
          }
        }
      }
    }

    return data;
  }
  return null;
}

String fetchFromSerial() {
  return port.readStringUntil('\n');
}
