extends Node2D

var type
var enemy_array = []
var built = false
var enemy
var ready = true
var towerRange = 150
var towerDamage = 20
var towerROF = 10

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * towerRange

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not $AnimationPlayer.is_playing():
			turn()
		if ready: 
#			fire()
			pass
	else:
		enemy = null
	
#func fire():
#	ready = false
#	fire_gun()
#	enemy.on_hit(towerDamage)
#	yield(get_tree().create_timer(towerROF), "timeout")
#	ready = true
#
#func fire_gun():
#	$AnimationPlayer.play("Fire")
	
func select_enemy(): 
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]
	
func turn():
	$Tower.look_at(enemy.position)
	
func _on_Range_body_entered(body):
	enemy_array.append(body.get_parent())
	print(enemy_array)


func _on_Range_body_exited(body):
	enemy_array.erase(body.get_parent())
