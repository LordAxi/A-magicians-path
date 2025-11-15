require "ruby2d"

$background_music_volume = 100


$background_music = Music.new($install_path + "assets/sounds/background_music.mp3")
$background_music.loop = true
$background_music.volume = $background_music_volume

def start_bgm
    $background_music.play
end    


