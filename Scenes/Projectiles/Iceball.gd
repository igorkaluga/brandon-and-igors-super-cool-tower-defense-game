extends Projectile
#extends "res://Scenes/Projectiles/Projectile.gd"
onready var tex = $Sprite.texture

var out_speed = GameData.projectiles.Iceball.projectile_speed
var out_piercing = GameData.projectiles.Iceball.projectile_piercing
var out_damage = GameData.projectiles.Iceball.projectile_damage
var effect = Globals.enemy_debuffs.Frozen
var out_asset = preload("res://Assets/Towers/Projectiles/IceBall.png")

func _ready():
	_initialize_values(out_speed, out_piercing, out_damage, out_asset)

