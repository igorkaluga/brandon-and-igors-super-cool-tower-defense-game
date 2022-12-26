extends Panel

onready var sell_button = $MarginContainer/VBoxContainer/TowerSell
var tower_type
func _ready():
	unshow_data()

func load_tower_display(tower):
	tower_type = tower
	
	var TowerIcon = $MarginContainer/VBoxContainer/AssetFrames/Frame/TowerIcon
	var TowerProjectile = $MarginContainer/VBoxContainer/AssetFrames/Frame2/TowerIcon
	var tower_range = $MarginContainer/VBoxContainer/TowerRange/Value
	var tower_rof = $MarginContainer/VBoxContainer/TowerROF/Value
	var projectile_damage = $MarginContainer/VBoxContainer/ProjectileDamage/Value
	var tower_value = $MarginContainer/VBoxContainer/TowerSell/Value
	var projectile = GameData.towers[tower].tower_projectile.instance()
	TowerIcon.texture = GameData.towers[tower].tower_asset
	TowerProjectile.texture = projectile.asset

	tower_range.text = String(GameData.towers[tower].tower_range)
	tower_rof.text = String(GameData.towers[tower].tower_rof)
	projectile_damage.text = String(projectile.damage)
	tower_value.text = String(GameData.towers[tower].tower_cost)

func show_data(tower):
	for i in get_tree().get_nodes_in_group("TowerInspector"):
		if i.is_in_group("SellButton") and tower.built == false:
			continue
		i.visible = true
		
func show_all_data(tower):
	for i in get_tree().get_nodes_in_group("TowerInspector"):
		i.visible = true
		
func unshow_data():
	for i in get_tree().get_nodes_in_group("TowerInspector"):
		i.visible = false
		
func can_drop_data(_pos, data):
	return true
	
func drop_data(_pos, data):
	var upgrade_cost = data["upgrade_cost"]
	var upgrade_value = data["upgrade_value"]
	var upgrade_type = data["upgrade_type"]

	
	if GameData.money >= upgrade_cost:
		data["card"].queue_free()
		GameData.money -= upgrade_cost
	
		if upgrade_type == "DMG":
			var projectile_name = GameData.towers[tower_type].tower_projectile_name
			GameData.projectiles[projectile_name].projectile_damage += upgrade_value
		elif upgrade_type == "RNG":
			GameData.towers[tower_type].tower_range += upgrade_value
		elif upgrade_type == "RoF":
			GameData.towers[tower_type].tower_rof *= upgrade_value
		for tower in get_tree().get_nodes_in_group(tower_type):
			tower.update_stats()
		load_tower_display(tower_type)
		print("Upgrade successful.")
	else:
		print("You're poor.")

