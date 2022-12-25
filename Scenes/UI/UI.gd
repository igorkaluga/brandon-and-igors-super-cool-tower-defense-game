extends CanvasLayer

onready var HUD = $HUD
var selected_tower
onready var tower_info = $HUD/TextureRect/MarginContainer/VBoxContainer/TowerInfo
onready var sell_button = $HUD/TextureRect/MarginContainer/VBoxContainer/TowerInfo/MarginContainer/VBoxContainer/TowerSell
var shop_screen = preload("res://Scenes/UI/Shop/Shop.tscn")
var shop
var is_shopping_round = false

func _ready():
	Globals.ui = self
	sell_button.connect("pressed", self, "_on_TowerSell_pressed")
	WaveHandler.connect("merchant_round", self, "store_available")
	add_towers_to_ui()	

func add_towers_to_ui():
	var available_towers = GameData.towers.keys()
	
	# Im sorry this code is so ugly igor i was so tired when i wrote it
	var i = 0
	for build_button in get_tree().get_nodes_in_group("build_buttons"):
		if i >= available_towers.size():
			return
		# Adds build buttons to available group
		build_button.add_to_group("build_button_available")
		var tower = load(GameData.towers[available_towers[i]].Resources)
		build_button.set_name(available_towers[i])
		build_button.get_node("TowerIcon").texture = tower.tower_asset
		build_button.set_name(available_towers[i])
		i += 1

func store_available(merchant):
	is_shopping_round = true
	$HUD/Shop.visible = true
	shop = shop_screen.instance()
	add_child(shop)

func _on_TowerSell_pressed():
	Globals.gamescene.sell_tower(selected_tower)
	unload_tower_display()

func _on_Information_input_event( viewport, event, shape_idx, tower ):
	if event.is_action_pressed("ui_accept") and event.pressed:
		load_tower_display(tower)
	
func unload_tower_display():
	tower_info.unshow_data()
	selected_tower = null
		
func load_tower_display(tower):
	if tower.name != "DragTower":
		selected_tower = tower
		tower_info.load_tower_display(tower.type)
		tower_info.show_data(tower)

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load(GameData.towers[tower_type].Location).instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("b905c523")
	
	var range_texture = Sprite.new()
	range_texture.position = Vector2(8,8)
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
	if is_shopping_round:
		is_shopping_round = false
		$HUD/Shop.visible = false
	$HUD/TextureRect/MarginContainer/VBoxContainer/Controls/PausePlayButton.pressed = false

func update_health():
	var health_bar = $HUD/TextureRect/MarginContainer/VBoxContainer/Info/HealthContainer/Health
	health_bar.text = String(GameData.health)
	
func update_money():
	var money_count = $HUD/TextureRect/MarginContainer/VBoxContainer/Info/MoneyContainer/Money
	money_count.text = String(GameData.money)
	
func update_current_round():
	var current_round = $HUD/TextureRect/MarginContainer/VBoxContainer/Info/RoundContainer/CurrentRound
	current_round.text = String(GameData.current_wave)
	
func update_total_rounds(total):
	var total_rounds = $HUD/TextureRect/MarginContainer/VBoxContainer/Info/RoundContainer/TotalRounds
	total_rounds.text = String(total)
	
func update_data():
	update_money()
	update_health()
	update_current_round()
	
func display_message(message_contents, time = null):
	var message = load("res://Scenes/UI/Message.tscn").instance()
	HUD.add_child(message)
	message.update_message(message_contents, time)
#	$GameScene/UI/HUD/MessageBox/Label.update_message(message_contents)
	
func _on_PausePlayButton_pressed():
	var gamescene = get_tree().get_root().find_node("GameScene", true, false)
	gamescene.connect("wave_end", self, "on_wave_end")
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().active_wave == false:
		get_parent().start_next_wave()
	else:
		get_tree().paused = true

func _on_FastForward_pressed():
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)

func _on_Shop_pressed():
	shop.popup()
