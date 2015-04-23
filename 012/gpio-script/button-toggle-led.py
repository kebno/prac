#!/usr/bin/python
# Based on tutorial by Alex Eames http://RasPi.tv

import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BCM)

# Inputs
B1 = 25
B2 = 24
GPIO.setup([B1,B2], GPIO.IN, pull_up_down=GPIO.PUD_UP)

# Outputs
LED1 = 18
LED2 = 23
GPIO.setup([LED1,LED2], GPIO.OUT, initial=GPIO.LOW)

def toggle_led(channel):
	if channel == B1:
		GPIO.output(LED1, not GPIO.input(LED1))
	elif channel == B2:
		GPIO.output(LED2, not GPIO.input(LED2))

	print "LED toggled"

# Register event callback functions
GPIO.add_event_detect(B1, GPIO.FALLING, callback=toggle_led, bouncetime=200)
GPIO.add_event_detect(B2, GPIO.FALLING, callback=toggle_led, bouncetime=200)

try:
	while True:
		sleep(0.5)

except KeyboardInterrupt:
	GPIO.cleanup()

finally:
	GPIO.cleanup()

