#!/usr/bin/python3
# Based on tutorial by Alex Eames http://RasPi.tv

import RPi.GPIO as GPIO
import subprocess
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

def wifi_up():
	return not subprocess.call('ip addr show wlan0 | grep -q "inet 10.0"',
			shell=True,
			executable='/bin/bash')

def check_wifi_updown():
	if wifi_up(): 
		GPIO.output(LED2, GPIO.HIGH)
	else:
		GPIO.output(LED2, GPIO.LOW)

def toggle_wifi(channel):
	if wifi_up():
		print "Bringing down Wifi"
		subprocess.call('sudo ifdown wlan0', shell=True,executable='/bin/bash')
	else: 
		# Blink the LED while Wifi waiting for IP address
		p = GPIO.PWM(LED1, 1)
		p.start(3)
		subprocess.call('sudo ifup wlan0',shell=True,executable='/bin/bash')
		p.stop()

# Register event callback functions
GPIO.add_event_detect(B1, GPIO.FALLING, callback=toggle_led, bouncetime=200)
GPIO.add_event_detect(B2, GPIO.FALLING, callback=toggle_wifi, bouncetime=10000)

try:
	while True:
		check_wifi_updown()
		sleep(1)

except KeyboardInterrupt:
	GPIO.cleanup()

finally:
	GPIO.cleanup()

