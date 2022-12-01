extends Node

func _ready():
	get_node("MainMenu/MarginContainer/VBoxContainer/NewGame").connect("pressed", self, "on_new_game_pressed")
	get_node("MainMenu/MarginContainer/VBoxContainer/ExitGame").connect("pressed", self, "on_quit_pressed")
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/Functional/GameScene.tscn").instance()
	add_child(game_scene)
	
func on_quit_pressed():
	get_tree().quit()
