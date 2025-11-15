require "ruby2d"
$hearts = 3

$heart1 = Tileset.new(
    $install_path + "assets/textures/gui/heart.png",
    tile_width: 10,
    tile_height: 10,
    scale: 32.0 / $tile_size.to_f / 2,
    padding:0,
    spacing:0,
    z: 400
)
$heart2 = Tileset.new(
    $install_path + "assets/textures/gui/heart.png",
    tile_width: 10,
    tile_height: 10,
    scale: 32.0 / $tile_size.to_f / 2,
    padding:0,
    spacing:0,
    z: 400
)
$heart3 = Tileset.new(
    $install_path + "assets/textures/gui/heart.png",
    tile_width: 10,
    tile_height: 10,
    scale: 32.0 / $tile_size.to_f / 2,
    padding:0,
    spacing:0,
    z: 400
)
$heart1.define_tile("red_full", 0, 0)
$heart1.define_tile("red_half", 1, 0)
$heart1.define_tile("red_empty", 2, 0)
$heart1.define_tile("green_full", 3, 0)
$heart1.define_tile("green_half", 4, 0)
$heart1.define_tile("green_empty", 4, 0)
$heart2.define_tile("red_full", 0, 0)
$heart2.define_tile("red_half", 1, 0)
$heart2.define_tile("red_empty", 2, 0)
$heart2.define_tile("green_full", 3, 0)
$heart2.define_tile("green_half", 4, 0)
$heart2.define_tile("green_empty", 4, 0)
$heart3.define_tile("red_full", 0, 0)
$heart3.define_tile("red_half", 1, 0)
$heart3.define_tile("red_empty", 2, 0)
$heart3.define_tile("green_full", 3, 0)
$heart3.define_tile("green_half", 4, 0)
$heart3.define_tile("green_empty", 4, 0)

$heart1.set_tile("red_full", [
    { x: ($w / 2) - (92 / 2),  y: $h - 22 -  (32.0 / $tile_size.to_f / 2 * 10) }
])
$heart2.set_tile("red_full", [
    { x: ($w / 2) - (92 / 2) + 10,  y: $h - 22 -  (32.0 / $tile_size.to_f / 2 * 10) }
])
$heart3.set_tile("red_full", [
    { x: ($w / 2) - (92 / 2) + 20,  y: $h - 22 -  (32.0 / $tile_size.to_f / 2 * 10)}
])

def replace_heart(heart, state)
    if heart == $heart1
        x = ($w / 2) - (92 / 2) 
    elsif heart == $heart2 
        x = ($w / 2) - (92 / 2) + 10 
    elsif heart == $heart3
        x = ($w / 2) - (92 / 2) + 20
    else
        puts "Error"
    end        
    heart.clear_tiles
    heart.set_tile(state,[
    { x: x,  y: $h - 22 -  (32.0 / $tile_size.to_f / 2 * 10) }
])
end


def take_damage(damage)
    $hearts += damage

    if $hearts <= 0
        replace_heart($heart1, "red_empty")
        replace_heart($heart2, "red_empty")
        replace_heart($heart3, "red_empty")

        game_over()
    elsif $hearts > 3 
        $hearts = 3
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_full")
        replace_heart($heart3, "red_full")
    elsif $hearts == 3
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_full")
        replace_heart($heart3, "red_full")

    elsif $hearts >= 2.5
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_full")
        replace_heart($heart3, "red_half")

    elsif $hearts >= 2
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_full")
        replace_heart($heart3, "red_empty")

    elsif $hearts >= 1.5
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_half")
        replace_heart($heart3, "red_empty")

    elsif $hearts >= 1
        replace_heart($heart1, "red_full")
        replace_heart($heart2, "red_empty")
        replace_heart($heart3, "red_empty")

    elsif $hearts >= 0.5
        replace_heart($heart1, "red_half")
        replace_heart($heart2, "red_empty")
        replace_heart($heart3, "red_empty")

    else
        $hearts = 0
        replace_heart($heart1, "red_empty")
        replace_heart($heart2, "red_empty")
        replace_heart($heart3, "red_empty")
    end
end

