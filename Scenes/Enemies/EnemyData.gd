extends KinematicBody2D

var hp = 100
signal death

func hit(damage):
	hp -= damage
	if hp <= 0:
		get_parent().destroy()
		self.queue_free()
