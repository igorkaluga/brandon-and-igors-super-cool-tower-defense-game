#extends Projectile
#
#var speed = GameData.projectiles.Fireball.projectile_speed
#var hp = GameData.projectiles.Fireball.projectile_hp
#var damage = GameData.projectiles.Fireball.projectile_damage
#var effect = Globals.enemy_debuffs.Burning
#var asset = preload("res://Assets/Towers/Projectiles/Fireball.png")
#
##func _init().(speed, hp, damage, asset, effect):
##	pass
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
