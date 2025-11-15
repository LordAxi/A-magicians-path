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
