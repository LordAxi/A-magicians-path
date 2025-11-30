require "ruby2d"

$pause_menu_values = {
  "hovered" => "continue",
  "state" => false,
  "x_offset" => 10,
  "y_offset" => -10
}

$pause_blur = Square.new(
        x: 0,
        y: 0,
        size: $w,
        color: [0, 0, 0, 0.0],
        z:9998
    )
def pause_menu()
    if $pause_menu_values["state"] == false && $game_state == "ingame"
      $pause_menu_values["state"] = true
      $game_state = "paused"
      $moveable = false
      $pause_menu_values["hovered"]
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

      $pause_text_quit = Text.new("Save and Quit to Menu",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_text_continue.height + $pause_text_options.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)

      $pause_text_exit = Text.new("Save and Exit to Desktop",
                      x: $pause_menu_values["x_offset"], y: $pause_text.height + $pause_text_continue.height + $pause_text_options.height + $pause_text_quit.height + $pause_menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: 100000)

      $pause_button_hover = Rectangle.new(color: [255, 255, 255, 0.5],
                      x: $pause_menu_values["x_offset"] / 2, y: $pause_text_continue.y, width: $pause_text_exit.width + $pause_menu_values["x_offset"], height: $pause_text_continue.height, z: $pause_text_continue.z.to_i - 1
      )
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
      $pause_button_hover.remove
    end
end

def pause_hover_button(button)
  if $pause_menu_values["state"] == true && $game_state == "paused"
    if button == "continue" || button == "options" || button == "quit" || button == "exit"
      $pause_menu_values["hovered"] = button
      case button
      when "continue"
        $pause_button_hover.y = $pause_text_continue.y
      when "options"
        $pause_button_hover.y = $pause_text_options.y 
      when "quit"
        $pause_button_hover.y = $pause_text_quit.y
      when "exit"
        $pause_button_hover.y = $pause_text_exit.y  
      end
    end
  end
end

def pause_next_hover(direction)
  case direction
    when 1
      case $pause_menu_values["hovered"]
          when "continue"
            pause_hover_button("exit")
          when "options"
            pause_hover_button("continue")
          when "quit"
            pause_hover_button("options")
          when "exit"
            pause_hover_button("quit")
      end
       when -1
      case $pause_menu_values["hovered"]
        when "continue"
            pause_hover_button("options")
          when "options"
            pause_hover_button("quit")
          when "quit"
            pause_hover_button("exit")
          when "exit"
            pause_hover_button("continue")
      end
    end
end

def pause_click_action(button)
  case button
      when "continue"
        pause_menu()
      when "options"
        $pause_button_hover.y = $pause_text_options.y 
      when "quit"
        pause_menu()
        menu()
      when "exit"
        #save()
        close 
      end
end