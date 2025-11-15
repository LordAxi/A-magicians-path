require "ruby2d"
require "json"


$tile_size = 20
$overlay_group = []
$block_group = []
#map = JSON.parse(File.read($install_path + "assets/maps/park.json"))

def load_map(map)
  def overlay (texture,place_x,place_y,size_x,size_y,layer)

    space_x = ($tile_size - size_x) / 2.0
    space_y = ($tile_size - size_y) / 2.0

    if size_y > size_x
      space_x = 0
      space_y = 0
    end
    $overlays = Image.new(
            texture,
            x: place_x * $tile_size + space_x,
            y: place_y * $tile_size + space_y,
            width:  size_x,
            height:  size_y,
            z: layer
          )
    $overlay_group << $overlays      
  end

  map.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell == 1
        what = $install_path + "assets/textures/blocks/grass.png"
      elsif cell == 2  
        what = $install_path + "assets/textures/blocks/dirt.png"
      elsif cell == 3.1 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_pink.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.2 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_red.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.3 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_yellow.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.4 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_orange.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.5 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_violett.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.6 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_light_violett.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 3.7 
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tulp_white.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
      elsif cell == 4
        what = $install_path + "assets/textures/blocks/dirt.png"
      overlay($install_path + "assets/textures/overlay/water.png", x, y, 20, 20, 100)
      elsif  cell == 5
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/sunflower.png", x, y, 20, 40, 100)
        shadow(x, y, 20, 40)
      elsif  cell == 6.1
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/tree_apple.png", x, y, 40, 60, 100)
      elsif cell == 7
        what = $install_path + "assets/textures/blocks/grass.png"
        overlay($install_path + "assets/textures/overlay/grass.png", x, y, 10, 10, 200)
        shadow(x, y, 10, 10)
    end  
      $blocks = Image.new(
        what,
        x: x * $tile_size,
        y: y * $tile_size,
        width: $tile_size,
        height: $tile_size,
        z: 0
      )
      $block_group << $blocks
    end
  end
end

def delete_map
      $block_group.each(&:remove)
      $block_group.clear  
      $overlay_group.each(&:remove)
      $overlay_group.clear
      $shadow_group.each(&:remove)
      $shadow_group.clear
end      