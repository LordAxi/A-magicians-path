require "ruby2d"
require "json"


$tile_size = 20
map = JSON.parse(File.read("assets/maps/park.json"))
def overlay (texture,place_x,place_y,size_x,size_y,layer)

  space_x = ($tile_size - size_x) / 2.0
  space_y = ($tile_size - size_y) / 2.0

  if size_y > size_x
    space_x = 0
    space_y = 0
  end
   Image.new(
          texture,
          x: place_x * $tile_size + space_x,
          y: place_y * $tile_size + space_y,
          width:  size_x,
          height:  size_y,
          z: layer
        )
end

map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if cell == 1
      what = "assets/textures/blocks/grass.png"
    elsif cell == 2  
      what = "assets/textures/blocks/dirt.png"
    elsif cell == 3.1 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_pink.png", x, y, 10, 10, 200)
      shadow(x, y, 10, 10)
    elsif cell == 3.2 
     what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_red.png", x, y, 10, 10, 200)
      shadow(x, y, 10, 10)
    elsif cell == 3.3 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_yellow.png", x, y, 10, 10, 200)
      shadow(x, y, 10, 10)
    elsif cell == 3.4 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_orange.png", x, y, 10, 10, 200)
      shadow(x, y, 10, 10)
    elsif cell == 3.5 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_violett.png", x, y, 10, 10, 200)
    elsif cell == 3.6 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_light_violett.png", x, y, 10, 10, 200)
    elsif cell == 3.7 
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tulp_white.png", x, y, 10, 10, 200)
    elsif cell == 4
      what = "assets/textures/blocks/dirt.png"
    overlay("assets/textures/overlay/water.png", x, y, 20, 20, 100)
    elsif  cell == 5
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/sunflower.png", x, y, 20, 40, 100)
      elsif  cell == 6.1
      what = "assets/textures/blocks/grass.png"
      overlay("assets/textures/overlay/tree_apple.png", x, y, 40, 60, 100)
    end
    Image.new(
      what,
      x: x * $tile_size,
      y: y * $tile_size,
      width: $tile_size,
      height: $tile_size,
      z: 0
    )
  end
end
