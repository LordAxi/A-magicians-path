require "ruby2d"

on :key_held do |event|
  $up_pressed = event.key == 'w'
  $down_pressed = event.key == 's'
  $left_pressed = event.key == 'a'
  $right_pressed = event.key == 'd'

  move_player()
end

on :key_down do |event|
  case event.key 
  when "escape"
    if $credits_values["state"] == true && $game_state == "credits"
      credits_menu()
    else  
      pause_menu()  
    end
  when "space"
    start_jump()
    
  when "left shift"
    sneak()  
  when "1"
    hotbar_select_slot(1)
    delete_map()
    load_map(JSON.parse(File.read($install_path + "assets/maps/flowers.json")))
  when "2"
    hotbar_select_slot(2)
    delete_map()
    load_map(JSON.parse(File.read($install_path + "assets/maps/park.json")))
  when "3"
    hotbar_select_slot(3)
  when "4"
    hotbar_select_slot(4)
  when "5"
    hotbar_select_slot(5)  
  when "6"
    take_damage(-1.5)
  when "up"
    case $game_state
    when "paused" 
      pause_next_hover(1)
    when "menu"
      menu_next_hover(1)
    end  
  when "down"
    case $game_state
    when "paused" 
      pause_next_hover(-1)
    when "menu"
      menu_next_hover(-1)
    end
  when "return"
    case $game_state
    when "paused" 
      pause_click_action($pause_menu_values["hovered"])
    when "menu"
      menu_click_action($menu_values["hovered"])
    end
  end  
end

on :mouse_scroll do |event|
  case event.delta_y
  when -1
    hotbar_scroll_slot(-1)
  when 1 
    hotbar_scroll_slot(1)
  end
end

on :controller_button_down do |event|  
  case event.button
  when :left_shoulder
    hotbar_scroll_slot(-1)
  when :right_shoulder 
    hotbar_scroll_slot(1)  
  when :up
    $controller_button_held_up = true
  when :down
    $controller_button_held_down = true
  when :left 
    $controller_button_held_left = true
  when :right 
    $controller_button_held_right = true
  when :a
    start_jump() 
  when :x
    sneak()  
  end  
end

on :controller_button_up do |event|
  case event.button
  when :up
    $controller_button_held_up = false
    $up_pressed = false
  when :down
    $controller_button_held_down = false
    $down_pressed = false
  when :left 
    $controller_button_held_left = false
    $left_pressed = false
  when :right 
    $controller_button_held_right = false
    $right_pressed = false
  end
end

on :mouse_move do |event|
  if $pause_menu_values["state"] == true && $game_state == "paused"
    if event.x.between?($pause_text_continue.x, $pause_text_continue.x + $pause_text_continue.width) &&
      event.y.between?($pause_text_continue.y, $pause_text_continue.y + $pause_text_continue.height)
      pause_hover_button("continue")
    elsif event.x.between?($pause_text_options.x, $pause_text_options.x + $pause_text_options.width) &&
          event.y.between?($pause_text_options.y, $pause_text_options.y + $pause_text_options.height)
          pause_hover_button("options")
    elsif event.x.between?($pause_text_quit.x, $pause_text_quit.x + $pause_text_quit.width) &&
          event.y.between?($pause_text_quit.y, $pause_text_quit.y + $pause_text_quit.height)
          pause_hover_button("quit")
    elsif event.x.between?($pause_text_exit.x, $pause_text_exit.x + $pause_text_exit.width) &&
          event.y.between?($pause_text_exit.y, $pause_text_exit.y + $pause_text_exit.height)
          pause_hover_button("exit")
    end
  elsif $game_state == "menu"
    if event.x.between?($menu_text_play.x, $menu_text_play.x + $menu_text_play.width) &&
      event.y.between?($menu_text_play.y, $menu_text_play.y + $menu_text_play.height)
      menu_hover_button("play")
    elsif event.x.between?($menu_text_options.x, $menu_text_options.x + $menu_text_options.width) &&
          event.y.between?($menu_text_options.y, $menu_text_options.y + $menu_text_options.height)
          menu_hover_button("options")
    elsif event.x.between?($menu_text_credits.x, $menu_text_credits.x + $menu_text_credits.width) &&
          event.y.between?($menu_text_credits.y, $menu_text_credits.y + $menu_text_credits.height)
          menu_hover_button("credits")
    elsif event.x.between?($menu_text_exit.x, $menu_text_exit.x + $menu_text_exit.width) &&
          event.y.between?($menu_text_exit.y, $menu_text_exit.y + $menu_text_exit.height)
          menu_hover_button("exit")
    end
  end
end
on :mouse_down do |event|
  if $pause_menu_values["state"] == true && $game_state == "paused"
    if event.x.between?($pause_text_continue.x, $pause_text_continue.x + $pause_text_continue.width) &&
      event.y.between?($pause_text_continue.y, $pause_text_continue.y + $pause_text_continue.height)
        pause_click_action("continue")
    elsif event.x.between?($pause_text_options.x, $pause_text_options.x + $pause_text_options.width) &&
          event.y.between?($pause_text_options.y, $pause_text_options.y + $pause_text_options.height)
          pause_click_action("options")
    elsif event.x.between?($pause_text_quit.x, $pause_text_quit.x + $pause_text_quit.width) &&
          event.y.between?($pause_text_quit.y, $pause_text_quit.y + $pause_text_quit.height)
          pause_click_action("quit")
    elsif event.x.between?($pause_text_exit.x, $pause_text_exit.x + $pause_text_exit.width) &&
          event.y.between?($pause_text_exit.y, $pause_text_exit.y + $pause_text_exit.height)
          pause_click_action("exit")
    end
  elsif $menu_values["state"] == true && $game_state == "menu"
    if event.x.between?($menu_text_play.x, $menu_text_play.x + $menu_text_play.width) &&
      event.y.between?($menu_text_play.y, $menu_text_play.y + $menu_text_play.height)
        menu_click_action("play")
    elsif event.x.between?($menu_text_options.x, $menu_text_options.x + $menu_text_options.width) &&
          event.y.between?($menu_text_options.y, $menu_text_options.y + $menu_text_options.height)
          menu_click_action("options")
    elsif event.x.between?($menu_text_credits.x, $menu_text_credits.x + $menu_text_credits.width) &&
          event.y.between?($menu_text_credits.y, $menu_text_credits.y + $menu_text_credits.height)
          menu_click_action("credits")
    elsif event.x.between?($menu_text_exit.x, $menu_text_exit.x + $menu_text_exit.width) &&
          event.y.between?($menu_text_exit.y, $menu_text_exit.y + $menu_text_exit.height)
          menu_click_action("exit")
    end
  end
end