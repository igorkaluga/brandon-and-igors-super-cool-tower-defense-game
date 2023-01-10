extends Button

signal upgrade_selected

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
		"RNG": [10, 25],
		"RoF": [0.50, .9]
	}
}

func get_drag_data(_pos):
	var data = {}
	var drag_preview = self.duplicate()
	data["upgrade_value"] = upgrade_value
	data["upgrade_type"] = upgrade_type
	data["upgrade_cost"] = upgrade_cost
	data["card"] = self

	set_drag_preview(drag_preview)
	
	return data
		
func can_drop_data(_pos, data):
	return false
	
func drop_data(_pos, data):
	print("Twoers")

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
		upgrade_value = rng.randi_range(upgrades.tier1.RNG[0], upgrades.tier1.RNG[1]) # Get random stat allocation
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
	emit_signal("upgrade_selected", self)
