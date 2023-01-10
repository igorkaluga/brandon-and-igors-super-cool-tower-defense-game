class_name HitBox
extends Area2D

var damage = GameData.projectiles.Arrow.projectile_damage

onready var collision_shape := $CollisionShape2D

func _init():
	collision_mask = 0
	
	collision_layer = 2

func set_disabled(is_disabled):
	collision_shape.set_deferred("disabled", is_disabled)
