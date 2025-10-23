 require "ruby2d"
# Oben bei deinen globalen Variablen:
$jumping = false
$jump_progress = 0.0
$jump_base_y = 0
$jump_height = 30

def start_jump
  return if $jumping
  $jumping = true
  $jump_progress = 0.0
  $jump_base_y = $player.y
end



