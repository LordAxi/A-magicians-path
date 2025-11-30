require "ruby2d"

$menu_values = {
  "hovered" => "play",
  "state" => false,
  "x_offset" => 10,
  "y_offset" => -10,
  "z" => 100000
}


def menu()
    if $menu_values["state"] == false && $game_state == "ingame" || $menu_values["state"] == false && $game_state == "credits"
      $menu_values["state"] = true
      $game_state = "menu"
      $moveable = false
      $menu_values["hovered"] = "play"
      $menu_background = Image.new($install_path + "assets/textures/gui/textbox.png",
                      x:0, y:0, width: $w, height: $h, z: $menu_values["z"] - 2)
      $menu_text = Text.new("A magicians path",
                      x: $menu_values["x_offset"], y:0,
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 100, color: 'blue', z: $menu_values["z"])

      $menu_text_play = Text.new("Play",
                      x: $menu_values["x_offset"], y: $menu_text.height + $menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: $menu_values["z"])

      $menu_text_options = Text.new("Options",
                      x: $menu_values["x_offset"], y: $menu_text.height + $menu_text_play.height + $menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: $menu_values["z"])

      $menu_text_credits = Text.new("Credits",
                      x: $menu_values["x_offset"], y: $menu_text.height + $menu_text_play.height + $menu_text_options.height + $menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: $menu_values["z"])

      $menu_text_exit = Text.new("Exit to Desktop",
                      x: $menu_values["x_offset"], y: $menu_text.height + $menu_text_play.height + $menu_text_options.height + $menu_text_credits.height + $menu_values["y_offset"],
                      font: $install_path + "assets/fonts/Jersey10-Regular.ttf", size: 40, color: 'black', z: $menu_values["z"])

      $menu_button_hover = Rectangle.new(color: [255, 255, 255, 0.5],
                      x: $menu_values["x_offset"] / 2, y: $menu_text_play.y, width: $menu_text_exit.width + $menu_values["x_offset"], height: $menu_text_play.height, z: $menu_text_play.z.to_i - 1
      )
    elsif $menu_values["state"] == true && $game_state == "menu"
      $menu_values["state"] = false
      $game_state = "ingame"
      $moveable = true
      $menu_background.remove
      $menu_text.remove
      $menu_text_play.remove
      $menu_text_options.remove
      $menu_text_credits.remove
      $menu_text_exit.remove
      $menu_button_hover.remove
    end
end

def menu_hover_button(button)
  if $menu_values["state"] == true && $game_state == "menu"
    if button == "play" || button == "options" || button == "credits" || button == "exit"
      $menu_values["hovered"] = button
      case button
      when "play"
        $menu_button_hover.y = $menu_text_play.y
      when "options"
        $menu_button_hover.y = $menu_text_options.y 
      when "credits"
        $menu_button_hover.y = $menu_text_credits.y
      when "exit"
        $menu_button_hover.y = $menu_text_exit.y  
      end
    end
  end
end

def menu_next_hover(direction)
  case direction
    when 1
      case $menu_values["hovered"]
          when "play"
            menu_hover_button("exit")
          when "options"
            menu_hover_button("play")
          when "credits"
            menu_hover_button("options")
          when "exit"
            menu_hover_button("credits")
      end
       when -1
      case $menu_values["hovered"]
        when "play"
            menu_hover_button("options")
          when "options"
            menu_hover_button("credits")
          when "credits"
            menu_hover_button("exit")
          when "exit"
            menu_hover_button("play")
      end
    end
end

def menu_click_action(button)
  case button
      when "play"
        menu()
      when "options"
        $menu_button_hover.y = $menu_text_options.y 
      when "credits"
        menu()
        credits_menu()
      when "exit"
        #save()
        close 
      end
end