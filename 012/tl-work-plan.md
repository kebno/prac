# Time Lapse Hardware & Software Work Plan

## Hardware

### Button and Indicator Circuit
  * Components
    - Red LED
    - Orange or Yellow LED
    - Green LED
    - Push button
    - RPi GPIO Cable
    - RPI GPIO Cable to breadboard connector
    - Small breadboard
    - Resistors, 3x (330-1k Ohm)
### Camera Mount
### RPi Case
### Power Supply and Cable
  * Extension cord to adapter or Long USB cable
    - I have one of these
  * test voltage of Supply on long cable
    - Voltage comes in at about 4.7-4.85 on long cable
    - On Current shorter cable, voltage is 5V

## Software
### Time Lapse Status Webpage
  * Why does vertical space change between Chrome/Firefox?
  * Add simple Flask app
  * Behavior - Periodically gets these values by jquery requests
    - Get number of files
    - Get size of image directory
    - Get percent of storage space used
    - Get latest image and its timestamp
    - Copy resized version of latest image (with timestamp) to page 


### Toggle RPi Wifi with Button
  * single button and 3 indicator LEDs
  * Behavior
    - On button press, Toggle Wifi -> (dis)connect to router
    - On connection, light up LED 2
    - On disconnection, power off LED 2
    - Button presses ignored while Wifi connecting
    - When Wifi is being brought on, blink LED 1 (connecting indicator, orange or yellow)
    - When Wifi is connected, turn off LED 1 (LED 2 should light at this time)
    - When camera takes a picture, turn on LED 3 for 1 second (red)


# Updates for Later
  * show remaining time lapse duration with available storage space
