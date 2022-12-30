class_name Projectile
extends Node2D

var speed = GameData.projectiles.Arrow.projectile_speed
var piercing = GameData.projectiles.Arrow.projectile_piercing
var damage = GameData.projectiles.Arrow.projectile_damage
var asset = preload("res://Assets/Towers/Projectiles/Arrow.png")

var lifetime := 1.0
var direction := Vector2.ZERO
var velocity = Vector2.RIGHT

onready var timer := $Timer
onready var hitbox := $HitBox
onready var sprite := $Sprite
onready var impact_detector := $Impact

var _target

func _initialize_values(inc_speed, inc_piercing, inc_damage, inc_asset):
	speed = inc_speed
	piercing = inc_piercing
	damage = inc_damage
	asset = inc_asset
	
	hitbox.damage = damage

func _ready():
#	set_as_toplevel(true)
	
	timer.connect("timeout", self, "queue_free")
	timer.start(lifetime)
	
	impact_detector.connect("body_entered", self, "_on_impact")

func _physics_process(delta):
	# If there is no active target, go straight 
	if not _target:
		position += speed * Vector2.RIGHT.rotated(velocity.angle()) * delta
		rotation = velocity.angle()
		return

	# If there is an active target, follow it
	if is_instance_valid(_target):
		look_at(_target.global_position)
		position = position.move_toward(_target.global_position, speed * delta)
		return

	# If the target is already dead, remove the target
	_target = null

func _on_impact(_body: Node):
	if _body.is_in_group("enemies"):
		piercing -= 1
		_target = null
		if piercing == 0:
			queue_free()
