extends Projectile

onready var tex = $Sprite.texture

var out_speed = GameData.projectiles.Fireball.projectile_speed
var out_piercing = GameData.projectiles.Fireball.projectile_piercing
var out_damage = GameData.projectiles.Fireball.projectile_damage
var out_effect = Globals.enemy_debuffs.Burning
var out_asset = preload("res://Assets/Towers/Projectiles/Fireball.png")
#
#func _initialize_values(out_speed, out_piercing, out_damage, out_asset):
#	pass
#
func _ready():
	_initialize_values(out_speed, out_piercing, out_damage, out_asset)
#	speed = GameData.projectiles.Fireball.projectile_speed
#	piercing = GameData.projectiles.Fireball.projectile_hp
#	damage = GameData.projectiles.Fireball.projectile_damage
##	var effect = Globals.enemy_debuffs.Burning
#	asset = preload("res://Assets/Towers/Projectiles/Fireball.png")
#
#func _ready():
#	$ExplosionRadius.connect("area_entered", self, "_on_Projectile_area_entered")
#
#func _on_Projectile_area_entered(area):
#	if area.is_in_group("enemies"):
#		print(area)
#		$ExplosionRadius/CollisionShape2D.set_disabled(false)
#		get_tree().create_timer(0.5).connect("timeout", self, "disable_hurtbox")
#		projectile_speed = 0.0
#		$Explosion.emitting = true
#		$Sprite.visible = false
#		timer.start(0.0)
#
##		self.queue_free()
#
#func disable_hurtbox():
#	$ExplosionRadius/CollisionShape2D.set_disabled(true)
