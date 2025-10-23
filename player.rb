require "ruby2d"

width = 20
height = 20
speed_multipier = 1
$speed = 20.0 / 64.0 * speed_multipier  
$moveable = true

$player = Image.new("player.png",
  width: width,
  height: height,
  x: $w / 2 - width / 2,
  y: $h / 2 - height / 2,
  z: 2000
)
$player_shadow = Image.new(
        "shadow.png",
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

def move_player
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

