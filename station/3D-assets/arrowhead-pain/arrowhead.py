import turtle 
import time

def seg(level, step, angle):
    if level>0:
        seg(level-1, step/2, -angle)
        T.rt(angle)
        seg(level-1, step/2,  angle)
        T.rt(angle)
        seg(level-1, step/2, -angle)
    else:
        T.fd(step)


# Main Code
T = turtle.Turtle()   
T.speed(25)
d = 220
b = 300
for level in range(9):
    T.penup()
    T.setpos((d*int(level/3)-b, d*(level%3)-b)) # pick new starting point
    T.setheading(0)                         # reset heading
    T.pendown()
    if level%2==1: # is level odd or even? if even then ...
        T.lt(60)
    seg(level, 200, 60)

while True:
    time.sleep(10)