require "ruby2d"

# Globale Variablen zum Merken der Objekte
$textbox       = nil
$text_line_1   = nil
$text_line_2   = nil
$text_line_3   = nil

def textbox(line1, line2, line3)
  # Wenn leer → entfernen!
  if line1 == ""
    $textbox&.remove
    $text_line_1&.remove
    $text_line_2&.remove
    $text_line_3&.remove
    return
  end

  # Vorherige ggf. löschen
  $textbox&.remove
  $text_line_1&.remove
  $text_line_2&.remove
  $text_line_3&.remove

  # Neue erstellen
  $textbox = Image.new(
    "textbox.png",
    x: 10, y: 235,
    width: 240 * 2, height: 60 * 2,
    z: 100000
  )

  $text_line_1 = Text.new(
    line1, x: 20, y: 240,
    font: 'Jersey10-Regular.ttf', size: 20, color: 'blue', z: 100000
  )

  $text_line_2 = Text.new(
    line2, x: 20, y: 260,
    font: 'Jersey10-Regular.ttf', size: 20, color: 'blue', z: 100000
  )

  $text_line_3 = Text.new(
    line3, x: 20, y: 280,
    font: 'Jersey10-Regular.ttf', size: 20, color: 'blue', z: 100000
  )
end

def reset_text()
 textbox("", "", "",)

end  





