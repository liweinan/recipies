DIM length AS INTEGER
length = 150

'front
DIM flu_x AS DOUBLE
DIM flu_y AS DOUBLE
DIM flu_z AS DOUBLE
flu_x = 100
flu_y = 200
flu_z = 100

DIM fru_x AS DOUBLE
DIM fru_y AS DOUBLE
DIM fru_z AS DOUBLE
fru_x = flu_x + length
fru_y = flu_y
fru_z = flu_z

DIM fld_x AS DOUBLE
DIM fld_y AS DOUBLE
DIM fld_z AS DOUBLE
fld_x = flu_x
fld_y = flu_y + length
fld_z = flu_z

DIM frd_x AS DOUBLE
DIM frd_y AS DOUBLE
DIM frd_z AS DOUBLE
frd_x = flu_x + length
frd_y = flu_y + length
frd_z = flu_z

'back
DIM blu_x AS DOUBLE
DIM blu_y AS DOUBLE
DIM blu_z AS DOUBLE
blu_x = flu_x
blu_y = flu_y
blu_z = flu_z + length

DIM bru_x AS DOUBLE
DIM bru_y AS DOUBLE
DIM bru_z AS DOUBLE
bru_x = fru_x
bru_y = fru_y
bru_z = flu_z + length

DIM bld_x AS DOUBLE
DIM bld_y AS DOUBLE
DIM bld_z AS DOUBLE
bld_x = fld_x
bld_y = fld_y
bld_z = flu_z + length

DIM brd_x AS DOUBLE
DIM brd_y AS DOUBLE
DIM brd_z AS DOUBLE
brd_x = frd_x
brd_y = frd_y
brd_z = flu_z + length

'3d -> 2d projections
DIM Pi AS DOUBLE
DIM z_axis_angle AS DOUBLE
DIM z_off_x AS DOUBLE
DIM z_off_y AS DOUBLE

Pi = 3.141593
z_axis_angle = 45 * Pi / 180
z_off_x = length * sin(z_axis_angle)
z_off_y = length * cos(z_axis_angle)

DIM d_flu_x AS DOUBLE
DIM d_flu_y AS DOUBLE
d_flu_x = flu_x
d_flu_y = flu_y

DIM d_fru_x AS DOUBLE
DIM d_fru_y AS DOUBLE
d_fru_x = fru_x
d_fru_y = fru_y

DIM d_frd_x AS DOUBLE
DIM d_frd_y AS DOUBLE
d_frd_x = frd_x
d_frd_y = frd_y

DIM d_fld_x AS DOUBLE
DIM d_fld_y AS DOUBLE
d_fld_x = fld_x
d_fld_y = fld_y

SCREEN 12
print z_off_x, z_off_y

' Draw front
LINE (d_flu_x, d_flu_y) - (d_fru_x, d_fru_y)
LINE (d_fld_x, d_fld_y) - (d_frd_x, d_frd_y)
LINE (d_flu_x, d_flu_y) - (d_fld_x, d_fld_y)
LINE (d_fru_x, d_fru_y) - (d_frd_x, d_frd_y)

' start point
PSET (d_flu_x, d_flu_y), 12
DRAW "D1 R1 U1 L1"

' back side projection
DIM d_blu_x AS DOUBLE
DIM d_blu_y AS DOUBLE
d_blu_x = d_flu_x + z_off_x
d_blu_y = d_flu_y - z_off_y
d_flu_y = flu_y

DIM d_bru_x AS DOUBLE
DIM d_bru_y AS DOUBLE
d_bru_x = d_fru_x + z_off_x
d_bru_y = d_fru_y - z_off_y

DIM d_brd_x AS DOUBLE
DIM d_brd_y AS DOUBLE
d_brd_x = d_frd_x + z_off_x
d_brd_y = d_frd_y - z_off_y

DIM d_bld_x AS DOUBLE
DIM d_bld_y AS DOUBLE
d_bld_x = d_fld_x + z_off_x
d_bld_y = d_fld_y - z_off_y

'draw back
LINE (d_blu_x, d_blu_y) - (d_bru_x, d_bru_y)
'LINE (d_bld_x, d_bld_y) - (d_brd_x, d_brd_y)
'LINE (d_blu_x, d_blu_y) - (d_bld_x, d_bld_y)
LINE (d_bru_x, d_bru_y) - (d_brd_x, d_brd_y)

'connect front and back
LINE (d_flu_x, d_flu_y) - (d_blu_x, d_blu_y)
LINE (d_fru_x, d_fru_y) - (d_bru_x, d_bru_y)
'LINE (d_fld_x, d_frd_y) - (d_bld_x, d_brd_y)
LINE (d_frd_x, d_frd_y) - (d_brd_x, d_brd_y)


