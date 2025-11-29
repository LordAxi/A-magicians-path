require "ruby2d"
$energy = 5 
$energy_bar_values = {
  "x" => $player.x,
  "y" => $player.y,
  "offset" => 20,
  "state" => ""
}

$energy_bar = Tileset.new(
    $install_path + "assets/textures/gui/energy_bar.png",
    tile_width: 50,
    tile_height: 10,
    scale: 32.0 / $tile_size.to_f / 2,
    padding:0,
    spacing:0,
    z: 400
)

$energy_bar.define_tile("5", 0, 0)
$energy_bar.define_tile("4.5", 0, 1)
$energy_bar.define_tile("4", 0, 2)
$energy_bar.define_tile("3.5", 0, 3)
$energy_bar.define_tile("3", 0, 4)
$energy_bar.define_tile("2.5", 0, 5)
$energy_bar.define_tile("2", 0, 6)
$energy_bar.define_tile("1.5", 0, 7)
$energy_bar.define_tile("1", 0, 8)
$energy_bar.define_tile("0.5", 0, 9)
$energy_bar.define_tile("0", 0, 10)

$energy_bar.set_tile("5", [
    { x: $energy_bar_values["x"] - $energy_bar_values["offset"],  y: $energy_bar_values["y"] - $energy_bar_values["offset"] }
])
def replace_energy(state)
    $energy_bar_values["state"] = state
    $energy_bar.clear_tiles
    $energy_bar.set_tile(state,[
    { x: $energy_bar_values["x"] - $energy_bar_values["offset"],  y: $energy_bar_values["y"] - $energy_bar_values["offset"] }
])
end
def change_energy(n)
  $energy += n
  if $energy >= 5
    $energy = 5
    replace_energy("5")
  elsif $energy >= 4.5
    replace_energy("4.5")
  elsif $energy >= 4
    replace_energy("4")
  elsif $energy >= 3.5
    replace_energy("3.5")
  elsif $energy >= 3
    replace_energy("3")
  elsif $energy >= 2.5
    replace_energy("2.5")
  elsif $energy >= 2
    replace_energy("2")
  elsif $energy >= 1.5
    replace_energy("1.5")
  elsif $energy >= 1
    replace_energy("1")
  elsif $energy >= 0.5
    replace_energy("0.5")
  else
    replace_energy("0")
  end
end