require 'ruby2d'
$w = 640
$h = ($w * 0.5625).to_i
require_relative "shadow.rb"
require_relative "map.rb" 
require_relative "input.rb"
require_relative "player.rb"
require_relative "shader.rb"
require_relative "sun-light.rb"
require_relative "jump.rb"
require_relative "hotbar.rb"
require_relative "background-music.rb"
require_relative "textbox.rb"
# require_relative "discordrpc.rb"



set title: "A magicians path"

set width: $w
set height: $h
set viewport_width: $w
set viewport_height: $h
set resizable: true
set borderless: false
set fullscreen: false
set diagnostics: true
set fps_cap: 720
set icon: "assets/textures/entities/player/player.png"


puts Window.height






fps = Text.new("FPS: ---", 
    style: 'bold',
    size: 20,
    color: 'blue',
    z: 10000)
    last_change = Time.now
last_change = Time.now


start_bgm()
update do
  if !$jumping == true
  $player_shadow.x = $player.x 
  $player_shadow.y = $player.y + $tile_size - 6
  else
    $player_shadow.x = $player.x
  end  
  if $controller_button_held_up == true
    $up_pressed = true
    move_player()
  elsif $controller_button_held_down == true
    $down_pressed = true
    move_player()
  elsif $controller_button_held_left == true
    $left_pressed = true
    move_player()
  elsif $controller_button_held_right == true    
    $right_pressed = true
    move_player()
  end  
  if $jumping

    offset = Math.sin($jump_progress) * $jump_height

    $player.y = $jump_base_y - offset
    
    $jump_progress += 0.04
    
    if $jump_progress >= Math::PI
      
      $jumping = false
 
    end
  end
  if Time.now - last_change >= 1.0
    fps.text= "FPS: #{Window.fps.round()}"
    puts "FPS:  #{Window.fps.round}"
    last_change = Time.now
  end
end

show
