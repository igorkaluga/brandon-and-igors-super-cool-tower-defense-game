extends PathFollow2D

export var speed := 50
export var damage := 1
export var value := 5
export var hp := 10
var timer
signal enemy_death
signal path_complete

var original_speed
var original_modulate

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _physics_process(delta):
	if unit_offset >= 1.0:
		emit_signal("path_complete", damage)
		queue_free()
	set_offset(get_offset() + speed * delta)

func init(tier):
	speed = tier.speed
	damage = tier.damage
	hp = tier.health
	value = tier.value
	
	original_speed = speed
	original_modulate = self.modulate

func hit(damage, effect = null):
	hp -= damage
	if hp <= 0:
		destroy()
	if effect != null:
		apply_effect(effect)

func destroy():
#	yield(get_tree().create_timer(0.02), "timeout")
	emit_signal("enemy_death", value)
	self.queue_free()
	
func apply_effect(effect):
	# If effect isnt permanent, create timer to end effects
	if effect.permanent == false:
		wait(effect.timeout)
	
	modulate = effect.effect_color
	speed = 0

	# TODO: DOT Damage here

	speed *= effect.speed_modifier
	
func wait(time):
	timer.wait_time += time
	timer.start()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("projectile") and hp > 0:
			hit(area.projectile_damage, area.effect_type)
		
func _on_timer_timeout():
	timer.stop()
	speed = original_speed
	modulate = Color("62ff00")#original_modulate
