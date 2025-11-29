require 'socket'
require 'json'
require 'securerandom'

class DiscordRPC
  DISCORD_RPC_VERSION = 1
  
  def initialize(client_id)
    @client_id = client_id
    @socket = nil
    @pid = Process.pid
    @last_update = Time.now - 5  # Starte mit 5 Sekunden Vorsprung
    @update_count = 0
    @update_window_start = Time.now
  end
  
  def connect
    socket_path = get_ipc_path
    
    if socket_path.nil?
      puts "Discord ist nicht geöffnet!"
      return false
    end
    
    begin
      @socket = UNIXSocket.new(socket_path)
      handshake
      puts "✓ Verbunden mit Discord!"
      true
    rescue => e
      puts "Fehler beim Verbinden: #{e.message}"
      false
    end
  end
  
  def disconnect
    @socket&.close
    puts "Verbindung getrennt"
  end
  
  def update_presence(details:, state: nil, timestamp: nil)
    # Rate Limiting: Max 5 Updates pro 20 Sekunden
    check_rate_limit
    
    activity = {
      details: details
    }
    
    activity[:state] = state if state
    
    # Timestamp nur setzen wenn explizit angegeben
    if timestamp
      activity[:timestamps] = { start: timestamp }
    end
    
    send_command('SET_ACTIVITY', {
      pid: @pid,
      activity: activity
    })
    
    @last_update = Time.now
    puts "✓ Status aktualisiert: #{details}"
  end
  
  def check_rate_limit
    now = Time.now
    
    # Reset Counter nach 20 Sekunden
    if now - @update_window_start >= 20
      @update_count = 0
      @update_window_start = now
    end
    
    @update_count += 1
    
    # Wenn wir 5 Updates erreicht haben, warte bis zum nächsten Fenster
    if @update_count > 5
      wait_time = 20 - (now - @update_window_start)
      if wait_time > 0
        puts "⏳ Rate Limit erreicht, warte #{wait_time.round(1)} Sekunden..."
        sleep wait_time
        @update_count = 1
        @update_window_start = Time.now
      end
    end
    
    # Minimum 4 Sekunden zwischen Updates
    time_since_last = now - @last_update
    if time_since_last < 4
      wait = 4 - time_since_last
      puts "⏳ Warte #{wait.round(1)}s (Rate Limit)..."
      sleep wait
    end
  end
  
  def clear_presence
    send_command('SET_ACTIVITY', { pid: @pid })
  end
  
  private
  
  def get_ipc_path
    if RUBY_PLATFORM =~ /mingw|mswin|cygwin/
      (0..9).each do |i|
        path = "\\\\.\\pipe\\discord-ipc-#{i}"
        return path if File.exist?(path)
      end
    else
      [
        ENV['XDG_RUNTIME_DIR'],
        ENV['TMPDIR'],
        ENV['TMP'],
        ENV['TEMP'],
        '/tmp'
      ].compact.each do |tmp_path|
        (0..9).each do |i|
          path = File.join(tmp_path, "discord-ipc-#{i}")
          return path if File.exist?(path)
        end
      end
    end
    nil
  end
  
  def handshake
    data = {
      v: DISCORD_RPC_VERSION,
      client_id: @client_id
    }
    write_frame(0, data)
    read_frame
  end
  
  def send_command(cmd, args)
    nonce = SecureRandom.uuid
    data = {
      cmd: cmd,
      args: args,
      nonce: nonce
    }
    write_frame(1, data)
    
    # Warte auf Antwort von Discord
    response = read_frame
    if response && response['evt'] == 'ERROR'
      puts "Discord Fehler: #{response['data']['message']}"
    end
    response
  end
  
  def write_frame(opcode, data)
    json_data = data.to_json
    header = [opcode, json_data.bytesize].pack('L<L<')
    @socket.write(header)
    @socket.write(json_data)
  end
  
  def read_frame
    header = @socket.read(8)
    return nil unless header
    
    opcode, length = header.unpack('L<L<')
    data = @socket.read(length)
    JSON.parse(data)
  rescue => e
    puts "Fehler beim Lesen: #{e.message}"
    nil
  end
end

# ============================================
# EINFACHER TEST
# ============================================

puts "Discord Rich Presence - Test Version"
puts "=" * 40
puts ""
puts "1. Erstelle eine Discord App: https://discord.com/developers/applications"
puts "2. Kopiere die Client ID und füge sie unten ein"
puts ""

# Trage hier deine Client ID ein:
CLIENT_ID = '1427638395269550193'

if CLIENT_ID == 'DEINE_CLIENT_ID_HIER'
  puts "⚠️  Bitte trage deine Client ID oben im Skript ein!"
  exit
end

rpc = DiscordRPC.new(CLIENT_ID)

if rpc.connect
  puts ""
  puts "🎮 Rich Presence ist aktiv!"
  puts "ℹ️  Discord Rate Limit: Max 5 Updates / 20 Sekunden"
  puts ""
  
  start_time = Time.now.to_i
  
  # Test 1: Hauptmenü
  rpc.update_presence(
    details: 'Im Hauptmenü',
    state: 'Gerade gestartet',
    timestamp: start_time
  )
  
  puts "Warte 5 Sekunden..."
  sleep 5
  
  # Test 2: Im Spiel
  rpc.update_presence(
    details: 'Spielt ein Match',
    state: 'Level 3',
    timestamp: Time.now.to_i
  )
  
  puts "Warte 5 Sekunden..."
  sleep 5
  
  # Test 3: Inaktiv (sollte jetzt schneller gehen!)
  puts "Wechsle zu Inaktiv..."
  rpc.update_presence(
    details: 'Inaktiv',
    state: 'Pausiert'
  )
  
  puts ""
  puts "✓ Tests abgeschlossen!"
  puts "Drücke Strg+C zum Beenden..."
  puts ""
  
  begin
    loop { sleep 1 }
  rescue Interrupt
    puts "\nBeende..."
    rpc.clear_presence
    rpc.disconnect
  end
else
  puts "❌ Konnte nicht mit Discord verbinden."
  puts "Stelle sicher, dass Discord läuft!"
end