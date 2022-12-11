extends PathFollow2D

var speed = 50
signal enemyCount


func _ready():
	pass

var hp = 100

#func hit(damage):
#	hp -= damage
#	print("Enemy hit")
#	if hp <= 0:
#		destroy()
##		$PathFollow2D.on_destroy()
##		get.parent().on_destroy()


func destroy():
	print("Enemy destroyed")
	$KinematicBody2D.queue_free()
	yield(get_tree().create_timer(0.02), "timeout")
	self.queue_free()
	emit_signal("enemyCount")

func _physics_process(delta):
	set_offset(get_offset() + speed * delta)
