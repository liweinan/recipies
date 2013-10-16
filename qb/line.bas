SCREEN 12

LINE (100, 100)-(300, 300), 10, , 63 'creates a styled line
LINE (100, 100)-(300, 300), 12, B , 255 'creates styled box shape
LINE (100, 400)-(200, 400)

DIM x1 AS DOUBLE
DIM y1 AS DOUBLE
DIM x2 AS DOUBLE
DIM y2 AS DOUBLE

x1 = 400
y1 = 100
x2 = 600
y2 = 100

LINE (x1, y1)-(x2, y2)

DIM xx1 AS DOUBLE
DIM yy1 AS DOUBLE
DIM xx2 AS DOUBLE
DIM yy2 AS DOUBLE
DIM theta AS DOUBLE
DIM angle AS DOUBLE
DIM Pi AS DOUBLE
Pi = 3.141593

xx1 = x1
yy1 = y1

angle = 60
theta = angle * Pi / 180

xx2 = x1 + COS(theta) * (x2 - x1)
yy2 = y2 + TAN(theta) * (xx2 - x1)

LINE (x1, y1)-(xx2, yy2)
LINE (x2, y2)-(xx2, yy2)

PRINT 1, 2, 3, 4, 5
PRINT x1, x2, xx2
PRINT COS(theta)

