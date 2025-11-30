require "ruby2d"
require "json"

$credits_values = {
  "state" => false,
  "x_offset" => 10,
  "y_offset" => 30,
  "z" => 1000000
}
$credits_line_group = []

def credits_menu()
  if $credits_values["state"] == false && $game_state == "ingame" || $credits_values["state"] == false && $game_state == "ingame"
    $moveable = false
    $credits_values["state"] = true
    $game_state = "credits"
    $credits_background = Rectangle.new(
            x:0,
            y:0,
            width: $w,
            height: $h,
            color: "black", 
            z: $credits_values["z"]-1
          )
    $credits = JSON.parse(File.read($install_path + "credits.json"))
    $credits.each_with_index do |text, id|
      line = Text.new(
        text,
        x: $credits_values["x_offset"],
        y: id * $credits_values["y_offset"],
        size: 20,
        z: $credits_values["z"],
        font: $install_path + "assets/fonts/Jersey10-Regular.ttf"
      )
      $credits_line_group << line
    end
  elsif $credits_values["state"] == true && $game_state == "credits"
    $credits_values["state"] = false && $game_state = "menu"
    $credits_line_group.each_with_index do |element, id|
      $credits_line_group[id].remove
    end
    $credits_line_group.clear
    $credits_background.remove
    $moveable = false
    menu()
  end
end

