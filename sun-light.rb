require "ruby2d"

$sun_light = Triangle.new(
  x1: 640,  y1: 0,
  x2: 640, y2: 360 / 1.5,
  x3: 360 / 1.5,   y3: 0,
  color: [[0, 0, 0, 0],[0, 0, 0, 0],[0, 0, 0, 0]],
  z: 9998
)

def set_sun_light(r,g,b,o)
  $sun_light.color = [[r, g, b, o],[0, 0, 0, 0],[0, 0, 0, 0]]
end
set_sun_light(255, 184, 0, 0.31)
