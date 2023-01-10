class_name HurtBox
extends Area2D

func _init():
	# Hurtbox should detect damage but not deal
	monitorable = false
	# Hurtbox layer
	collision_mask = 2

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hitbox: HitBox):
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
