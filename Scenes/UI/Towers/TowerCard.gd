extends Panel

onready var sell_button = $MarginContainer/VBoxContainer/TowerSell

func _ready():
	unshow_data()

func load_tower_display(tower):
	var TowerIcon = $MarginContainer/VBoxContainer/AssetFrames/Frame/TowerIcon
	var TowerProjectile = $MarginContainer/VBoxContainer/AssetFrames/Frame2/TowerIcon
	var tower_range = $MarginContainer/VBoxContainer/TowerRange/Value
	var tower_rof = $MarginContainer/VBoxContainer/TowerROF/Value
	var projectile_damage = $MarginContainer/VBoxContainer/ProjectileDamage/Value
	var tower_value = $MarginContainer/VBoxContainer/TowerSell/Value
	var projectile = GameData.towers[tower].tower_projectile.instance()
	TowerIcon.texture = GameData.towers[tower].tower_asset
	TowerProjectile.texture = projectile.projectile_asset

	tower_range.text = String(GameData.towers[tower].tower_range)
	tower_rof.text = String(GameData.towers[tower].tower_rof)
	projectile_damage.text = String(projectile.projectile_damage)
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
