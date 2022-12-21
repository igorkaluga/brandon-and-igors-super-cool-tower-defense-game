extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type
var build_cost

var total_waves = 20
var active_wave = false
var enemies_in_wave = 0

signal game_over
signal wave_end


func _ready():
	Globals.gamescene = self
	#Load the UI to the game
	#Note: May want to break this out into a conditonal for when we develop different UI
	#	   For different scenes
	var ui = load("res://Scenes/UI/UI.tscn").instance()
	add_child(ui)
	
	Globals.ui.update_total_rounds(total_waves)
	map_node = get_node("Map1")
	add_towers_to_gamescene()
		
	Globals.ui.display_message("good luck asshole")

func sell_tower(tower):
	GameData.money += tower.TowerValues.tower_cost
	map_node.get_node("TowerExclusion").set_cellv(tower.build_tile, -1)

	tower.queue_free()

func add_towers_to_gamescene():
	for i in get_tree().get_nodes_in_group("build_button_available"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
		print("Loaded tower: ", i.get_name())

func _process(delta):
	Globals.ui.update_data()
	
	if build_mode:
		update_tower_preview()
	if active_wave and enemies_in_wave == 0:
		wave_completed()

func _unhandled_input(event):
	if build_mode:
		if event.is_action_released("ui_accept") and build_mode == true:
			verify_and_build()
			cancel_build_mode()
		if event.is_action_released("ui_cancel") and build_mode == true:
			cancel_build_mode()
	if not build_mode:
		if event is InputEventMouseButton and event.pressed:
			Globals.ui.unload_tower_display()

# Wave Func
func start_next_wave():
	active_wave = true
	GameData.current_wave += 1
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2), "timeout")
	spawn_enemies(wave_data)
	
func wave_completed():
	active_wave = false
	print("Wave complete!")
	emit_signal("wave_end")
	GameData.money += 200
	Globals.ui.display_message("Wave Completed!", 0.5)
	if GameData.current_wave == total_waves:
		Globals.uidisplay_message("You won! Heres some cash.")
		GameData.money += 500
	
func retrieve_wave_data():
	var wave_data = WaveHandler.create_wave_data(GameData.current_wave)
	enemies_in_wave = wave_data.size()
	print("Enemies in Wave: ", enemies_in_wave)
	return wave_data
	
func spawn_enemies(wave_data):
	for new_enemy in wave_data:
		new_enemy.connect("enemy_death", self, "on_enemy_death")
		new_enemy.connect("path_complete", self, "on_path_complete")
		map_node.get_node("Path2D").add_child(new_enemy, true)
		# Timer between mobs spawning
		yield(get_tree().create_timer(.5), "timeout")
	
func on_enemy_death(enemy_value):
	enemies_in_wave -= 1
	GameData.money += enemy_value
	
# Building Func
func initiate_build_mode(tower_type):
#	build_cost = GameData.towers[tower_type].Cost
	var tower = load(GameData.towers[tower_type].Resources)
	build_cost = tower.tower_cost
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
		var new_tower = load(GameData.towers[build_type].Location).instance()
		new_tower.position = build_location
		new_tower.build_tile = build_tile
		new_tower.built = true
		new_tower.type = build_type
		
		map_node.get_node("Towers").add_child(new_tower, true)
		# Sets a tile in the TowerExclusion zone so we cant double build
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 9)
		GameData.money -= build_cost

func on_path_complete(damage):
	Globals.camera.shake(100)
	GameData.health -= damage
	enemies_in_wave -= 1
	print(GameData.health)
	if GameData.health <= 0:
		emit_signal("game_over")
