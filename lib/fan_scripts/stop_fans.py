import RPi.GPIO as GPIO
import init_fans

fanPin = 23

print("Stopping fans")
GPIO.output(fanPin, GPIO.LOW)