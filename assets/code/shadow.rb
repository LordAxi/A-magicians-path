require "ruby2d"


def shadow (x_of_object, y_of_object, size_x, size_y)

  space_x = ($tile_size - size_x) / 2.0
  space_y = ($tile_size - size_y) / 2.0

  if size_y > size_x
    space_x = 0
    space_y = 0
  end
    Image.new(
        "shadow.png",
        x: x_of_object * $tile_size + space_y,
        y: y_of_object * $tile_size  + size_y + space_y - 3,
        width: size_x,
        height: size_y,
        z: 199
    )
end    