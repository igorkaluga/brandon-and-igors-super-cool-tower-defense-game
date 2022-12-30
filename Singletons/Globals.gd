extends Node

var camera
var ui
var gamescene
enum Tiers {TIER1, TIER2, TIER3}


var enemy_debuffs = {
	"Frozen": {
		"permanent": false,
		"timeout": 1,
		"dot": 3,
		"speed_modifier": .5,
		"effect_color": Color("2560a4")
		},
	"Burning": {
		"permanent": false,
		"timeout": 1,
		"dot": 3,
		"speed_modifier": .5,
		"effect_color": Color("2560a4")
		}
	}
	
var enemy_tier_stats = {
	"tier1": {
		"health": 10,
		"damage": 1,
		"value": 1,
		"speed": 50
	},
	"tier2": {
		"health": 50,
		"damage": 3,
		"value": 5,
		"speed": 75
	},
	"tier3": {
		"health": 100,
		"damage": 10,
		"value": 15,
		"speed": 50
	},
	"tier4": {
		"health": 150,
		"damage": 20,
		"value": 30,
		"speed": 25
	}
}

var towers_dict = {
	"BasicTower": {
		"Location": "res://Scenes/Towers/BasicTower.tscn",
		"Resources": "res://Resources/TowerResources/ArrowTowerData.tres",
		"tower_range": 100,
		"tower_rof": 1,
		"tower_cost": 100,
		"tower_projectile_name": "Arrow",
		"tower_projectile": preload("res://Scenes/Projectiles/Arrow.tscn"),
		"tower_asset": preload("res://Assets/Towers/TowerSpritePlaceHolder.png")
		},
	"FireTower": {
		"Location": "res://Scenes/Towers/FireTower.tscn",
		"Resources": "res://Resources/TowerResources/FireTowerData.tres",
		"tower_range": 75,
		"tower_rof": 1.25,
		"tower_cost": 300,
		"tower_projectile_name": "Fireball",
		"tower_projectile": preload("res://Scenes/Projectiles/Fireball.tscn"),
		"tower_asset": preload("res://Assets/Towers/FireTower.png")
		},
	"IceTower": {
		"Location": "res://Scenes/Towers/IceTower.tscn",
		"Resources": "res://Resources/TowerResources/IceTowerData.tres",
		"tower_range": 100,
		"tower_rof": 1.25,
		"tower_cost": 300,
		"tower_projectile_name": "Iceball",
		"tower_projectile": preload("res://Scenes/Projectiles/Iceball.tscn"),
		"tower_asset": preload("res://Assets/Towers/IceTower.png")
		}
	}

# Expects to see the name of a tower that is declared in the towers_dict dictionary 
func add_tower(tower):
	GameData.towers[tower] = Globals.towers_dict[tower]
#	GameData.towers["FireTower"] = Globals.towers_dict["FireTower"]   
	ui.add_towers_to_ui()
	gamescene.add_towers_to_gamescene()

func simple_timer(time):
	yield(get_tree().create_timer(time), "timeout")
