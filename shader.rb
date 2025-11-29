require "ruby2d"
    $shader = Square.new(
        x: 0,
        y: 0,
        size: $w,
        color: [0, 0, 0, 0.0],
        z:9999
    )

#[r, g, b, opacity]
def shader (r, g, b, opacity)
    $color_opacity = [r, g, b, opacity]
    $shader.color = $color_opacity
end
