require 'richpresence-rb'

# Deine Discord Application Client ID
CLIENT_ID = '1427638395269550193'
 
# RichPresence initialisieren
rpc = RichPresence.new(CLIENT_ID)

begin
  puts "Verbinde mit Discord..."
  rpc.connect
  puts "✓ Verbunden!"
  
  # Status setzen
  rpc.update(
    details: 'Im Hauptmenü',
    state: 'Gerade gestartet'
  )
  puts "✓ Status gesetzt: Im Hauptmenü"
  
  sleep 5
  
  # Status aktualisieren
  rpc.update(
    details: 'Spielt ein Match',
    state: 'Level 3'
  )
  puts "✓ Status gesetzt: Spielt ein Match"
  
  sleep 5
  
  # Mit Timestamp
  rpc.update(
    details: 'Inaktiv',
    state: 'Pausiert',
    start_timestamp: Time.now.to_i
  )
  puts "✓ Status gesetzt: Inaktiv"
  
  puts "\nDrücke Strg+C zum Beenden..."
  
  # Endlosschleife
  loop { sleep 1 }
  
rescue Interrupt
  puts "\nBeende..."
  rpc.clear
  rpc.disconnect
  puts "✓ Verbindung getrennt"
rescue => e
  puts "Fehler: #{e.message}"
  puts e.backtrace
end