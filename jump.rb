require "ruby2d"

$jump = {
  "state" => false,
  "progress" => 0.0,
  "base_y" => 0,
  "height" => 30,
  "energy" => 1,
}
def start_jump
  if !$sneaking && $energy >= $jump["energy"] && $moveable
    return if $jump["state"]
    change_energy(- $jump["energy"])
    $jump["state"] = true
    $jump["progress"] = 0.0
    $jump["base_y"] = $player.y
  end  
end



