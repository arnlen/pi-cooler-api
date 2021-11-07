import RPi.GPIO as GPIO

fanPin = 23

GPIO.setmode(GPIO.BCM)
GPIO.setup(fanPin, GPIO.OUT)