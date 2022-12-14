extends PathFollow2D

var speed = 50
var damage = 1
var value = 5
signal enemy_death
signal path_complete


func _ready():
	pass

func destroy():
	$KinematicBody2D.queue_free()
	yield(get_tree().create_timer(0.02), "timeout")
	self.queue_free()
	emit_signal("enemy_death", value)
	
func apply_effect(effect_type, effect_duration):
	# Freezing
	if effect_type == "Freezing":
		print("Enemy frozen!")
	# Burning
	# 

func _physics_process(delta):
	if unit_offset >= 1.0:
		emit_signal("path_complete", damage)
		queue_free()
	set_offset(get_offset() + speed * delta)
