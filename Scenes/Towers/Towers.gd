extends Node2D

var type
var enemy_array = []
var enemy
var built = false
var ready = true

# Default values; probably not necessary to have
var tower_range = 50
var tower_projectile = "res://Scenes/Projectiles/Arrow.tscn"
var tower_rof = 1

# Where the projectile will originate on the tower sprite
onready var firingPosition = $FiringPosition

func _init(_tower_range, _tower_rof, _tower_projectile):
	tower_range = _tower_range
	tower_rof = _tower_rof
	tower_projectile = load(_tower_projectile)

func _ready():
	if built:
		$Range/CollisionShape2D.get_shape().radius = tower_range

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if ready: 
			fire()
	else:
		enemy = null
	
func fire():
	ready = false
	print("Firing")
	$FiringPosition.look_at(enemy.position)
	var projectile = tower_projectile.instance()
	get_parent().add_child(projectile)
	projectile.global_position = $FiringPosition/Position2D.global_position
	
	projectile.velocity = enemy.position - projectile.position
	projectile._target = enemy

	yield(get_tree().create_timer(tower_rof), "timeout")
	ready = true

func select_enemy(): 
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]

func _on_Range_body_entered(body):
	if body.is_in_group("enemies"):
		enemy_array.append(body.get_parent())
		print(enemy_array)

func _on_Range_body_exited(body):
	if body.is_in_group("enemies"):
		enemy_array.erase(body.get_parent())
