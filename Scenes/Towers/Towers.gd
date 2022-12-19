extends Node2D

export(Resource) var TowerValues

var type
var enemy_array = []
var enemy
var built = false
var ready = true

# Where the projectile will originate on the tower sprite
onready var firingPosition = $FiringPosition

func _ready():
	$Information.connect("input_event", Globals.ui, "_on_Information_input_event", [self])
	if built:
		$Range/CollisionShape2D.get_shape().radius = TowerValues.tower_range

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if ready: 
			fire()
	else:
		enemy = null
	
func fire():
	ready = false
	$FiringPosition.look_at(enemy.position)
	var projectile = TowerValues.tower_projectile.instance()
	get_parent().add_child(projectile)
	projectile.global_position = $FiringPosition/Position2D.global_position
	
	projectile.velocity = enemy.position - projectile.position
	projectile._target = enemy

	yield(get_tree().create_timer(TowerValues.tower_rof), "timeout")
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

func _on_Range_body_exited(body):
	if body.is_in_group("enemies"):
		enemy_array.erase(body.get_parent())
