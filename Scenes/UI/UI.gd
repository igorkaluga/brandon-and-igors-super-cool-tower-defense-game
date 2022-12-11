extends CanvasLayer


func _ready():
	# Get list of available towers
	var available_towers = GameData.towers.keys()

	# Im sorry this code is so ugly igor i was so tired when i wrote it
	var i = 0
	for build_button in get_tree().get_nodes_in_group("build_buttons"):
		if i >= available_towers.size():
			return
			
		build_button.set_name(available_towers[i])
		print(GameData.towers[available_towers[i]].Asset)
		build_button.get_node("TowerIcon").texture = load(GameData.towers[available_towers[i]].Asset)
		build_button.set_name(available_towers[i])
		i += 1

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("b905c523")
	
	var range_texture = Sprite.new()
#	range_texture.position = Vector2(16,16)
	var scaling = drag_tower.get_node("Range/CollisionShape2D").shape.radius / 300.0
	var texture = load("res://Assets/Towers/range_overlay.png")
	range_texture.scale = Vector2(scaling, scaling)
	range_texture.texture = texture
	range_texture.modulate = Color("b905c523")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/DragTower/TowerSprite").modulate = Color(color)
		get_node("TowerPreview/Sprite").modulate = Color(color)

func on_wave_end():
	$HUD/TextureRect/MarginContainer/VBoxContainer/Controls/PausePlayButton.pressed = false

func _on_PausePlayButton_pressed():
	var gamescene = get_tree().get_root().find_node("GameScene", true, false)
	gamescene.connect("wave_end", self, "on_wave_end")
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
#		get_parent().current_wave += 1
		get_parent().start_next_wave()
	else:
		get_tree().paused = true

# Commented out because I havent built it yet
#func _on_FastForward_pressed():
#	if Engine.get_time_scale() == 2.0:
#		Engine.set_time_scale(1.0)
#	else:
#		Engine.set_time_scale(2.0)
