extends Node

var camera
var ui
var gamescene

var enemy_debuffs = {
	"Frozen": {
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
		"Resources": "res://Resources/TowerResources/ArrowTowerData.tres"
		},
	"FireTower": {
		"Location": "res://Scenes/Towers/FireTower.tscn",
		"Resources": "res://Resources/TowerResources/FireTowerData.tres"
		},
	"IceTower": {
		"Location": "res://Scenes/Towers/IceTower.tscn",
		"Resources": "res://Resources/TowerResources/IceTowerData.tres"
		}
	}

func simple_timer(time):
	yield(get_tree().create_timer(time), "timeout")
