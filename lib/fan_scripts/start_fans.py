import RPi.GPIO as GPIO
import init_fans

fanPin = 23

print("Starting fans!")
GPIO.output(fanPin, GPIO.HIGH)