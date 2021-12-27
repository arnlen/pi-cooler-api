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

def getIp(interface):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,
        struct.pack('256s', interface[:15])
    )[20:24])

if message1 == "ip":
    message1 = "Alpha IP:"
    message2 = getIp('wlan0') # For Ethernet, switch to: getIp('eth0')

print('message 1:', message1)
print("message 2:", message2)

lcd.cursor_pos = (0, 0)
lcd.write_string(message1)
lcd.cursor_pos = (1, 0)
lcd.write_string(message2)