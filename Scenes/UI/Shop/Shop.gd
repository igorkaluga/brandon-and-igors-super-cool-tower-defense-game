extends Control

var tower_cards = preload("res://Scenes/UI/Towers/TowerCard.tscn")
var upgrade_cards = preload("res://Scenes/UI/Shop/TowerUpgradeCards.tscn")
onready var available = $ShopWindow/HBoxContainer/CardsContainer/HBoxContainer
onready var upgrade_grid = $ShopWindow/HBoxContainer/CardsContainer/Cards/GridContainer
var rng = RandomNumberGenerator.new()
var generated_shop = false

func _ready():
	if not generated_shop:
		generate_shop()
		
func generate_shop():
	var available_towers = GameData.towers.keys()
	rng.randomize()

	var number_upgrade_cards = rng.randi_range(3, 5)
	for i in number_upgrade_cards:
		var new_upgrade_card = upgrade_cards.instance()
		new_upgrade_card.get_upgrade_info(Globals.Tiers.TIER1, 50)
		upgrade_grid.add_child(new_upgrade_card)
		new_upgrade_card.connect("upgrade_selected", self, "_upgrade_selected")
		
	# Load Available Towers
	for i in GameData.towers.keys():
		print(i)
		var new_tower = tower_cards.instance()
		var tower_info = GameData.towers[i]
#		print(tower_info.TowerValues.tower_range)
		new_tower.load_tower_display(i)
		available.add_child(new_tower)
		new_tower.show_all_data(tower_info)

	generated_shop = true
	
# Right now this does nothing but tell user to drag the card
func _upgrade_selected(selected_card):
	print("you selected a card?")
	$ShopWindow/HBoxContainer/CardsContainer/Confirmation.visible = true
