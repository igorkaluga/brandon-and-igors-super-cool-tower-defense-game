extends Area2D

var velocity = Vector2(0,1)
var projectile_speed = 750
var projectile_hp = 2
var projectile_damage = 0
var _target
var start = Vector2.ZERO
var max_time = 1.0

func _init(_projectile_speed, _projectile_hp, _projectile_damage):
	projectile_speed = _projectile_speed
	projectile_hp = _projectile_hp
	projectile_damage = _projectile_damage
	
func _ready():
	connect("body_entered", self, "_on_Projectile_body_entered")
	var timer = Timer.new()
	timer.wait_time = max_time
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")

func on_timeout():
	self.queue_free()

func _process(delta):
	# If there is no active target, go straight 
	if not _target:
		position += projectile_speed * Vector2.RIGHT.rotated(velocity.angle()) * delta
		rotation = velocity.angle()
		return
#		position += transform.x * speed * delta

	# If there is an active target, follow it
	if is_instance_valid(_target):
		look_at(_target.global_position)
		position = position.move_toward(_target.global_position, projectile_speed * delta)
		return
		
	# If the target is already dead, remove the target
	_target = null

func _on_Projectile_body_entered(area):
	if area.is_in_group("enemies"):
		area.hit(projectile_damage)
		_target = null
		projectile_hp -= 1
		if projectile_hp == 0:
			self.queue_free()
		