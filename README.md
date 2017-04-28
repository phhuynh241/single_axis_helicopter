Single Axis Helicopter
---
The goal of this project is to be able to drive a DC Motor with a propeller to control the angle of the lever by using a Pulse Width Modulation Signal. The Infrared Distance Sensor will measure the distance from the lever to the base and give us feedback, and we use this feedback and implement it in a Closed Loop Control System so that we can maintain the setpoint the user wants it at.

AUTHOR
---
Peter Huynh

CONTENTS
---
Built a Single Axis Helicopter using the MDE 8051 Trainer (microcontroller) with a PID controller. The propeller on the DC motor changes based on user input from the switches on the microcontroller. It uses a variety of components such as timers, interrupts, and PWM signal.

Picture(s)
---
Board:
Will insert later when I figure it out.

User Guide
---
Controls:
  * 8-bit dip switch to control desired angle 

COMPONENTS
---
Schematic:

Will insert schematic when I figure it out

1.	Microcontroller: 8051 MDE Trainer Board with the DS89C450 chip
2.	Analog to Digital Converter ADC0804 - The ADC transfers the analog signal from the IR sensor to the microcontroller, and since the IR sensor outputs an analog voltage to the ADC, the ADC will output 0 to 255 and send it back to the 8051. This value will act as the process variable.
3.	DC Motor - The DC motor is connected by a propeller, and the DC motor can take in a voltage ranging from 0V to 5V that is supplied by the microcontroller board. A Pulse Width Modulation signal and a MOSFET is used to change the speed of the motor.
4.	Capacitor - 2 capacitors with .01 μF and they are used as decoupling capacitors.
5.	Resistor - We use one 100k ohm resistor and it is connected to the Gate of the MOSFET. A 10k ohm resistor is connected to the CLKIN and CLKR pin of the ADC.
6.	MOSFET IRL510 – The MOSFET is used for low side switching. The PWM signal is connected to the Gate, the drain is connected to the DC Motor and the source is grounded. When Vgs (gate-source) is greater than Vgs(th) (threshold), the motor will receive the voltage supplied by the microcontroller. Connected to the Gate is a 100k ohm current limiting resistor that will protect the circuit from drawing too much current
7.	IR Distance Sensor (Sharp GP270A51SK0F) – For the distance sensor, at 4cm, the sensor will output about 2.5V from the middle pin. At 15cm, the sensor will output about 0.5V 
8.	Pulse Width Modulation – The PWM is programmed by us, and it is not an actual peripheral. The PWM creates an analog value that is sent to the 8051 microcontroller and it is connected to the gate of the MOSFET.
9.	Potentiometer – One potentiometer is connected to Vin (-) of the ADC, and the other potentiometer is connected to the Vref/2 of the ADC. The potentiometer connected to Vin controls the zero-point of the sensor while the Vref/2 is controls the scaling of the range for the sensor. These potentiometers will have the IR sensor have the range and scale these values for it to be correct 

BUGS
---
- Didn't implement the derivative portion of the PID controller, so does not adjust as accurately, will implement at a later date
