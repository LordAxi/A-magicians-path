require "ruby2d"


#[r, g, b, opacity]
def shader (r, g, b, opacity)
    $color_opacity = [r, g, b, opacity]
    Square.new(
        x: 0,
        y: 0,
        size: $w,
        color: $color_opacity,
        z:9999
    )
end
