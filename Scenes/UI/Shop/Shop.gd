extends Control

var tower_cards = preload("res://Scenes/UI/Towers/TowerCard.tscn")
onready var available = $ShopWindow/HBoxContainer/CardsContainer/HBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	var available_towers = GameData.towers.keys()
	# Load Available Towers
	for i in GameData.towers.keys():
		print(i)
		var new_tower = tower_cards.instance()
		var tower_info = load(GameData.towers[i].Location).instance()
		print(tower_info.TowerValues.tower_range)
		new_tower.load_tower_display(tower_info)
		available.add_child(new_tower)
		new_tower.show_all_data(tower_info)
	
		
