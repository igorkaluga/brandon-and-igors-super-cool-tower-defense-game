extends PathFollow2D

var speed = 150
var hp = 1000
signal death

func _ready():
	pass

func on_hit(damage):
	hp -= damage
	if hp <= 0:
		on_destroy()

func on_destroy():
	$KinematicBody2D.queue_free()
	yield(get_tree().create_timer(0.02), "timeout")
	self.queue_free()
	emit_signal("enemyCount")

func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_offset(get_offset() + speed * delta)
