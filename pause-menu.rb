require "ruby2d"

$pause_menu_values = {
  
  "state" => false,
  "x_offset" => 10,
  "y_offset" => -10
}

$pause_blur = Square.new(
        x: 0,
        y: 0,
        size: $w,
        color: [0, 0, 0, 0.0],
        z:9999
    )
def pause_menu()
    if $pause_menu_values["state"] == false && $game_state == "ingame"
      $pause_menu_values["state"] = true
      $game_state = "paused"
      $moveable = false
      $pause_blur.color = [0, 0, 0, 0.3]
      $pause_text = Text.new("Pause Menu",
                      x: $pause_menu_values["x_offset"], y:0,
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 100, color: 'blue', z: 100000)
      $pause_text_continue = Text.new("Continue",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)
      $pause_text_options = Text.new("Options",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_text_continue.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)
      $pause_text_quit = Text.new("Quit to Menu",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_text_continue.height + $pause_text_options.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)
      $pause_text_exit = Text.new("Exit to Desktop",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_text_continue.height + $pause_text_options.height + $pause_text_quit.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)
    elsif $pause_menu_values["state"] == true && $game_state == "paused"
      $pause_menu_values["state"] = false
      $game_state = "ingame"
      $moveable = true
      $pause_blur.color = [0, 0, 0, 0]
      $pause_text.remove
      $pause_text_continue.remove
      $pause_text_options.remove
      $pause_text_quit.remove
      $pause_text_exit.remove
    end
end
