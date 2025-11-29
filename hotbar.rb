require "ruby2d"

width = 92
height = 20
$slot_active = 1

$hotbar = Image.new(
    $install_path + "assets/textures/gui/hotbar.png",
    width: width,
    height: height,
    x: ($w / 2) - (width / 2),
    y: $h - height,
    z: 20000
)
$hotbar_slot_active = Image.new(
    $install_path + "assets/textures/gui/hotbar_slot_active.png",
    width: height ,
    height: height,
    x: ($w / 2) - (width / 2),
    y: $h - height,
    z: 20001
)

def hotbar_select_slot(slot) 
    $slot_active = slot
    $hotbar_slot_active.x = (slot -1) *20  + $hotbar.x - (slot * 2) +2
end   

def hotbar_scroll_slot(direction)
    slot_scroll_to = $slot_active
    slot_scroll_to += direction
    if slot_scroll_to < 1
        slot_scroll_to = 5
        hotbar_select_slot(slot_scroll_to)
    elsif slot_scroll_to > 5
        slot_scroll_to = 1
        hotbar_select_slot(slot_scroll_to)
    else  
        hotbar_select_slot(slot_scroll_to)  
    end    
end    
