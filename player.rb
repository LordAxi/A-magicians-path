require "ruby2d"

width = 20
height = 20
speed_multiplier = 0.5
$speed = 20.0 / 32.0 * speed_multiplier  
$moveable = true
$sneaking = false

$player = Image.new($install_path + "assets/textures/entities/player/player.png",
  width: width,
  height: height,
  x: $w / 2 - width / 2,
  y: $h / 2 - height / 2,
  z: 2000
)
$player_shadow = Image.new(
        $install_path + "assets/textures/general/shadow.png",
  x: 0,
  y: 0,
  width: width,
  height: height,
  z: 1999
)
  
$up_pressed = false
$down_pressed = false
$left_pressed = false
$right_pressed = false
def set_speed(local_speed_multiplier)
  $speed = (20.0 / 32.0).to_f * local_speed_multiplier
end

def move_player
  if $moveable
    count = 0
    count += 1 if $up_pressed
    count += 1 if $down_pressed
    count += 1 if $left_pressed
    count += 1 if $right_pressed

    speed_adjusted = $speed
    speed_adjusted /= Math.sqrt(2) if count >= 2

    if $left_pressed && $player.x > 0
      $player.x -= speed_adjusted
    end
    if $right_pressed && $player.x < $w - 20
      $player.x += speed_adjusted
    end
    if $up_pressed && $player.y > 0
      $player.y -= speed_adjusted
    end
    if $down_pressed && $player.y < $h - 20
      $player.y += speed_adjusted
    end
  end
end

def sneak()
  if !$jumping && !$sneaking && $moveable
    $player.height = height = 10
    $sneaking = true
    $player.y += 10
    set_speed(0.25)
    elsif $sneaking == true
    $player.height = height = 20
    $sneaking = false 
    $player.y -= 10
    set_speed(0.5)
    end
end

