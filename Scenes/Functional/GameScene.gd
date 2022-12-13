extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type
var build_cost

var current_wave = 0
var active_wave = false
var enemies_in_wave = 0

signal game_over
signal wave_end

var health = 100


func _ready():
	#Load the UI to the game
	#Note: May want to break this out into a conditonal for when we develop different UI
	#	   For different scenes
	var ui = load("res://Scenes/UI/UI.tscn").instance()
	add_child(ui)
	
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
		print("Available towers loaded:")
		print(i.get_name())
	
	# Set Health and Money
	$UI.update_health(health)
	$UI.update_money()
	
func _process(delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()

# Wave Func
func start_next_wave():
	active_wave = true
	current_wave += 1
	$UI.update_round(current_wave)
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2), "timeout")
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = WaveHandler.create_wave_data(current_wave)
	enemies_in_wave = wave_data.size()
	print(enemies_in_wave)
	return wave_data
	
func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instance()
		new_enemy.connect("enemy_death", self, "on_enemy_death")
		new_enemy.connect("path_complete", self, "on_path_complete")
		map_node.get_node("Path2D").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]), "timeout")
	
func on_enemy_death(enemy_value):
	enemies_in_wave -= 1
	GameData.money += enemy_value
	$UI.update_money()
	if enemies_in_wave == 0:
		active_wave = false
		emit_signal("wave_end")
	
# Building Func
func initiate_build_mode(tower_type):
	build_cost = GameData.towers[tower_type].Cost
	if build_cost > GameData.money:
		return
		
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false

func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	if build_valid and GameData.money >= build_cost:
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instance()
		print("BUILDING ", new_tower)
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		map_node.get_node("Towers").add_child(new_tower, true)
		# The 2 in this refers to a transparent tile that disallows multiple towers to be placed at once
		# Todo: Find a better way to do this lol
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 2)
		
		GameData.money -= build_cost
		$UI.update_money()

func on_path_complete(damage):
	Globals.camera.shake(100)
	health -= damage
	print(health)
	if health <= 0:
		$UI.update_health(health)
		emit_signal("game_over")
	else:
		$UI.update_health(health)
