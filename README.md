# Wheelchair pressure mat

ESP3903 project @ NUS

Authors:

* Jasdip Chauhan
* Keith Daigle
* Sam Yuyitung

Code to support a capacitor based pressure sensor matrix

## Arduino Code

[file](muxCode/muxCode.ino)

This code cycles through and outputs the 16 capacitance values in picoFarads
This code is based off the
[Capacitive  Meter](https://www.arduino.cc/en/Tutorial/CapacitanceMeter)
example from the Arduino website

The ordering of the output array is

key: (mux #).(mux input #)

```
1.1,1.2,1.3,1.4;1.5,1.6,1.7,1.8;2.1,2.2,2.3,2.4;2.5,2.6,2.7,2.8(\n)
```

This value is written to the serial and can be consumed by other applications

## Heatmap code

[file](heatmap.pde)

This is built with [Processing](https://processing.org). When building make sure
that you update the Serial port accordingly to match the one that the Arduino
is running off. This program maps the each capacitance to an appropriate colour.
Adjusting the MIN_CAP and MAX_CAP can allow you to work with you capacitive
sensors!!
