require 'ruby2d'
require 'chunky_png'

# Beispiel: Canvas rendern
# Annahme: du hast ein 800x600 Fenster
window = Window.new(width: 800, height: 600)

# Screenshot-Funktion
def take_screenshot(filename="screenshot.png")
  data = Window.capture # liefert ein Array von Pixeln
  png = ChunkyPNG::Image.new(800, 600)
  
  data.each_with_index do |color, index|
    x = index % 800
    y = index / 800
    png[x, y] = color
  end

  png.save(filename)
end
show