extends Node

var money = 500
var health = 100
var current_wave = 1

var towers = {
	"BasicTower": {
		"Location": "res://Scenes/Towers/BasicTower.tscn",
		"Asset": "res://Assets/Towers/TowerSpritePlaceHolder.png",
		"Cost": 100
		},
	"FireTower": {
		"Location": "res://Scenes/Towers/FireTower.tscn",
		"Asset": "res://Assets/Towers/FireTower.png",
		"Cost": 300
		},
	"IceTower": {
		"Location": "res://Scenes/Towers/IceTower.tscn",
		"Asset": "res://Assets/Towers/IceTower.png",
		"Cost": 300
		}
	}
