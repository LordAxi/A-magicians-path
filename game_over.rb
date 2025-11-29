require "ruby2d"

def game_over()
    shader(255, 0, 0, 0.1)
    sleep(0.1)
    shader(255, 0, 0, 0.2)
    sleep(0.1)
    shader(255, 0, 0, 0.3)
    sleep(0.1)
    shader(255, 0, 0, 0.4)
    $moveable = false
$game_over_message = Image.new( $install_path + "assets/textures/gui/game_over.png",
                        x: ($w / 2.0) - (375 / 2.0),
                        y: ($h / 2.0) - (55.625 / 2.0),
                        z: 9999999999,
                        width: 375,
                        height: 55.625,
                    )
end