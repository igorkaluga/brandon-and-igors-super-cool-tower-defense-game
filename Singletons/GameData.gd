extends Node

var money = 1000
var health = 100
var current_wave = 0

# Players current towers
var towers = {
	"BasicTower": {
		"Location": "res://Scenes/Towers/BasicTower.tscn",
		"Resources": "res://Resources/TowerResources/ArrowTowerData.tres"
		},
	"FireTower": {
		"Location": "res://Scenes/Towers/FireTower.tscn",
		"Resources": "res://Resources/TowerResources/FireTowerData.tres"
		},
#	"IceTower": {
#		"Location": "res://Scenes/Towers/IceTower.tscn",
#		"Resources": "res://Resources/TowerResources/IceTowerData.tres"
#		}
	}
