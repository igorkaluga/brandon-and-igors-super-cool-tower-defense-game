extends KinematicBody2D

export(Resource) var debuff

var timer
export var hp = 10
signal death
var original_speed 
var original_modulate
#
#func _init(_health, _speed, _damage, _value):
#	hp = _health
#	get_parent().speed = _speed
#	get_parent().damage = _damage
#	get_parent().value = _value

func _process(delta):
	if hp <= 0:
		get_parent().destroy()
		self.queue_free()
		
func wait(time):
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	
	timer.wait_time = time
	timer.start()

	
func _on_timer_timeout():
	get_parent().speed = original_speed
	get_parent().modulate = Color("62ff00")#original_modulate

func apply_effect(effect):
	# Store original values
	original_speed = get_parent().speed
	original_modulate = get_parent().modulate
	
	# If effect isnt permanent, create timer to end effects
	if effect.permanent == false:
		wait(effect.timeout)
	
	get_parent().modulate = effect.effect_color
	get_parent().speed = 0

	# DOT Damage here

	get_parent().speed *= effect.speed_modifier

func hit(damage, effect = null):
	hp -= damage
	if hp <= 0:
		get_parent().destroy()
		self.queue_free()
	if effect != null:
		apply_effect(effect)
