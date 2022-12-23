extends Button

onready var Info = $VBoxContainer/Info
onready var Cost = $VBoxContainer/Cost
var rng = RandomNumberGenerator.new()
enum UpgradeTier {TIER1, TIER2, TIER3}

var upgrade_cost
var upgrade_value
var upgrade_type

func ready():
	rng.randomize()

var upgrades = {
	"tier1": {
		"DMG": [1, 3],
		"RNG": [1.25, 2],
		"RoF": [0.50, .9]
	}
}

func get_upgrade_info(incoming_upgrade_type, incoming_upgrade_cost):
	rng.randomize()
	
	# Set upgrade type
	upgrade_type = choose_key(upgrades.tier1.keys())
	var upgrade_symbol = " +" if upgrade_type == "DMG" else  " x"
	# Set upgrade stats
	if upgrade_type == "DMG":
		upgrade_value = rng.randi_range(upgrades.tier1.DMG[0], upgrades.tier1.DMG[1]) # Get random stat allocation
		upgrade_value = stepify(upgrade_value, 0.1) # Round to one decimial
	elif upgrade_type == "RNG":
		upgrade_value = rand_range(upgrades.tier1.RNG[0], upgrades.tier1.RNG[1]) # Get random stat allocation
		upgrade_value = stepify(upgrade_value, 0.1) # Round to one decimial'
	elif upgrade_type == "RoF":
		upgrade_value = rand_range(upgrades.tier1.RoF[0], upgrades.tier1.RoF[1]) # Get random stat allocation
		upgrade_value = stepify(upgrade_value, 0.1) # Round to one decimial
		
	# Set upgrade cost
	upgrade_cost = incoming_upgrade_cost * upgrade_value # Multiply shop base price by the size of the increase
	upgrade_cost *= rng.randi_range(2, 5) # Then to be mean, multiply that by 2-5. Lol.

	$VBoxContainer/Info.text = str(upgrade_type, upgrade_symbol, upgrade_value)
	$VBoxContainer/Cost.text = str(upgrade_cost)



func choose_key(array):
	return array[randi() % array.size()]

func _on_UpgradeCard_pressed():
	if upgrade_type == "DMG":
		GameData.projectiles.Arrow.projectile_damage += upgrade_value
	elif upgrade_type == "RNG":
		GameData.towers.BasicTower.tower_range *= upgrade_value
	elif upgrade_type == "RoF":
		GameData.towers.BasicTower.tower_rof *= upgrade_value

	print("cheeee: ", upgrade_value)
