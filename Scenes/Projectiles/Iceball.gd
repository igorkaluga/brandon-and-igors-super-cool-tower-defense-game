extends "res://Scenes/Projectiles/Projectile.gd"

var speed = GameData.projectiles.Iceball.projectile_speed
var hp = GameData.projectiles.Iceball.projectile_hp
var damage = GameData.projectiles.Iceball.projectile_damage
var effect = Globals.enemy_debuffs.Frozen
var asset = preload("res://Assets/Towers/Projectiles/IceBall.png")

func _init().(speed, hp, damage, asset, effect):
	pass
