require 'ruby2d'
$w = 640
$h = ($w * 0.5625).to_i
$install_path = "/home/axi/A-magicians-path/"
$game_state = "ingame"
require_relative "input.rb"
require_relative "shadow.rb"
require_relative "map.rb" 
require_relative "player.rb"
require_relative "shader.rb"
require_relative "sun-light.rb"
require_relative "jump.rb"
require_relative "hotbar.rb"
require_relative "background-music.rb"
require_relative "textbox.rb"
require_relative "hearts.rb"
require_relative "game_over.rb"
require_relative "energy-bar.rb"
require_relative "armor-bar.rb"
require_relative "pause-menu.rb"
require_relative "menu.rb"
require_relative "credits.rb"
menu()

set title: "A magicians path"

set width: $w
set height: $h
set viewport_width: $w
set viewport_height: $h
set resizable: true
set borderless: false
set fullscreen: true
set diagnostics: true
set fps_cap: 720
set icon: $install_path + "assets/textures/entities/player/player.png"
load_map(JSON.parse(File.read($install_path + "assets/maps/flowers.json")))

puts Window.height






fps = Text.new("FPS: ---", 
    style: 'bold',
    size: 20,
    color: 'blue',
    z: 1000000000)
    last_change = Time.now
    last_change_2 = Time.now


start_bgm()
update do
  

  if $jump["state"] == false && $sneaking == false
  $player_shadow.x = $player.x 
  $player_shadow.y = $player.y + $tile_size - 6
  elsif $sneaking == true
    $player_shadow.x = $player.x 
    $player_shadow.y = $player.y + $tile_size / 2 - 6
  elsif $jump["state"] == true
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
  if $jump["state"] && $moveable
    
    offset = Math.sin($jump["progress"]) * $jump["height"]
    
    $player.y = $jump["base_y"] - offset
    $energy_bar_values["x"] = $player.x
    $energy_bar_values["y"] = $player.y
    replace_energy($energy_bar_values["state"])
    $jump["progress"] += 0.04
    
    if $jump["progress"] >= Math::PI
      $player.y = $jump["base_y"]
      $energy_bar_values["x"] = $player.x
    $energy_bar_values["y"] = $player.y
    replace_energy($energy_bar_values["state"])
      $jump["state"] = false
 
    end
  end
  if Time.now - last_change >= 1.0
    fps.text= "FPS: #{Window.fps.round()}"
    puts "FPS:  #{Window.fps.round}"
    last_change = Time.now

    change_energy(0.5)
  elsif Time.now - last_change_2 >= 0.02
    if $credits_values["state"] == true && $game_state == "credits"
      $credits_line_group.each_with_index do |element, id|
        $credits_line_group[id].y -= 0.16
        lines = $credits_line_group.size - 1
        
        if $credits_line_group[lines].y < $credits_line_group[lines].height
          credits_menu()
        
        end
      
      end
    end
    last_change_2 = Time.now
  end

end

show
