extends Node

var money = 1000
var health = 100
var current_wave = 0

# Players current towers
var towers = {
	"BasicTower": {
		"Location": "res://Scenes/Towers/BasicTower.tscn",
		"Resources": "res://Resources/TowerResources/ArrowTowerData.tres",
		"tower_range": 100,
		"tower_rof": 1,
		"tower_cost": 100,
		"tower_projectile_name": "Arrow",
		"tower_projectile": preload("res://Scenes/Projectiles/Arrow.tscn"),
		"tower_asset": preload("res://Assets/Towers/TowerSpritePlaceHolder.png")
		}
	}

var projectiles = {
	"Arrow": {
		"projectile_damage": 7,
		"projectile_speed": 1000,
		"projectile_piercing": 1,
		"projectile_asset": preload("res://Assets/Towers/Projectiles/Arrow.png")
	},
	"Fireball": {
		"projectile_damage": 100,
		"projectile_speed": 250,
		"projectile_piercing": 1,
		"projectile_effect": "explosion",
		"projectile_asset": preload("res://Assets/Towers/Projectiles/Fireball.png")
	},
	"Iceball": {
		"projectile_damage": 10,
		"projectile_speed": 250,
		"projectile_piercing": 1,
		"projectile_asset": preload("res://Assets/Towers/Projectiles/IceBall.png")
	}
}
