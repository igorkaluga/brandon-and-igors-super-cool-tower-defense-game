extends PathFollow2D

var speed = 150
var hp = 100

func _ready():
	pass

func destroy():
	print("Enemy destroyed")
	$KinematicBody2D.queue_free()
	yield(get_tree().create_timer(0.02), "timeout")
	self.queue_free()
	emit_signal("enemyCount")

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)
