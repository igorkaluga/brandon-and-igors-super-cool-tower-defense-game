extends Node

func _ready():
	load_main_menu()
	
func load_main_menu():
	get_node("MainMenu/MarginContainer/VBoxContainer/NewGame").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/MarginContainer/VBoxContainer/ExitGame").connect("pressed", self, "on_quit_pressed")

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/Functional/GameScene.tscn").instance()
	game_scene.connect("game_over", self, "on_game_over")
	add_child(game_scene)
	
func on_quit_pressed():
	get_tree().quit()
	
func on_game_over():
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/Functional/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
