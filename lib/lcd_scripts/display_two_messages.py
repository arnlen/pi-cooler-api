from RPLCD.gpio import CharLCD
import socket
import fcntl
import struct
import sys

lcd = CharLCD(cols=16, rows=2, pin_rs=37, pin_e=35, pins_data=[33, 31, 29, 23])

message1 = ""
message2 = ""

if len(sys.argv) > 1:
    message1 = sys.argv[1]

if len(sys.argv) > 2:
    message2 = sys.argv[2]

print('message 1:', message1)
print("message 2:", message2)

lcd.cursor_pos = (0, 0)
lcd.write_string(message1)
lcd.cursor_pos = (1, 0)
lcd.write_string(message2)