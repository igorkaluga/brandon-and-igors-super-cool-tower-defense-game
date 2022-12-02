extends CanvasLayer


func _ready():
	var towerFrame = $HUD/TowerBar/Frame
	var availableTowers = load("res://Scenes/Towers/BasicTower.tscn").instance()
	$HUD/TowerBar/Frame.add_child(availableTowers, true)

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("b905c523")
	
	var range_texture = Sprite.new()
	range_texture.position = Vector2(32,32)
#	Need to figure out how to share tower range to this UI
#	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
#	range_texture.scale = Vector2(scaling, scaling)
#	var texture = load("res://Assets/Towers/range_overlay.png")
#	range_texture.texture = texture
#	range_texture.modulate = Color("b905c523")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
#	move_child(get_node("TowerPreview"), 0)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/TowerSprite").modulate = Color(color)


func _on_PausePlayButton_pressed():
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().current_wave += 1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true

# Commented out because I havent built it yet
#func _on_FastForward_pressed():
#	if Engine.get_time_scale() == 2.0:
#		Engine.set_time_scale(1.0)
#	else:
#		Engine.set_time_scale(2.0)
