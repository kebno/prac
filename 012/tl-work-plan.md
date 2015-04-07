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
  * test voltage of Supply on long cable

## Software
  * Create Repo for all of this
    - Directories for each component (webpage, RPi GPIO routines, TL)
### Time Lapse Status Webpage
  * Why does vertical space change between Chrome/Firefox?
  * Add simple Flask app
  * Behavior
    - Get number of files
    - Get size of image directory
    - Get percent of storage space used
    - Copy resized version of latest image to page
    - Get timestamp of latest image

### Toggle RPi Wifi with Button
  * single button and 3 indicator LEDs
  * Behavior
    - On button press, Toggle Wifi -> (dis)connect to router
    - On connection, light up LED 1 (green)
    - On disconnection, power off LED 1 (green)
    - Button presses ignored while Wifi connecting
    - When Wifi is being brought on, light up LED 2 (connecting indicator, orange or yellow)
    - When Wifi is connected, turn off LED 2 (LED 1 should light at this time)
    - When camera takes a picture, turn on LED 3 for 1 second (red)



# Updates for Later
  * show remaining time lapse duration with available storage space
