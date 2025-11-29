require "ruby2d"
$armor = 0
$armor_bar_values = {
  "x" => ($w / 2) - (92 / 2) + 92 - 50 * 32.0 / $tile_size.to_f / 2,
  "y" => $h - 22 -  (32.0 / $tile_size.to_f / 2 * 10),
  "offset" => 0,
  "state" => ""
}

$armor_bar = Tileset.new(
    $install_path + "assets/textures/gui/armor_bar.png",
    tile_width: 50,
    tile_height: 10,
    scale: 32.0 / $tile_size.to_f / 2,
    padding:0,
    spacing:0,
    z: 2000
)

$armor_bar.define_tile("5", 0, 0)
$armor_bar.define_tile("4.5", 0, 1)
$armor_bar.define_tile("4", 0, 2)
$armor_bar.define_tile("3.5", 0, 3)
$armor_bar.define_tile("3", 0, 4)
$armor_bar.define_tile("2.5", 0, 5)
$armor_bar.define_tile("2", 0, 6)
$armor_bar.define_tile("1.5", 0, 7)
$armor_bar.define_tile("1", 0, 8)
$armor_bar.define_tile("0.5", 0, 9)
$armor_bar.define_tile("0", 0, 10)

$armor_bar.set_tile($armor.to_s, [
    { x: $armor_bar_values["x"] - $armor_bar_values["offset"],  y: $armor_bar_values["y"] - $armor_bar_values["offset"] }
])
def replace_armor(state)
    $armor_bar_values["state"] = state
    $armor_bar.clear_tiles
    $armor_bar.set_tile(state,[
    { x: $armor_bar_values["x"] - $armor_bar_values["offset"],  y: $armor_bar_values["y"] - $armor_bar_values["offset"] }
])
end
def change_armor(n)
  $armor += n
  if $armor >= 5
    $armor = 5
    replace_armor("5")
  elsif $armor >= 4.5
    replace_armor("4.5")
  elsif $armor >= 4
    replace_armor("4")
  elsif $armor >= 3.5
    replace_armor("3.5")
  elsif $armor >= 3
    replace_armor("3")
  elsif $armor >= 2.5
    replace_armor("2.5")
  elsif $armor >= 2
    replace_armor("2")
  elsif $armor >= 1.5
    replace_armor("1.5")
  elsif $armor >= 1
    replace_armor("1")
  elsif $armor >= 0.5
    replace_armor("0.5")
  else
    replace_armor("0")
  end
end