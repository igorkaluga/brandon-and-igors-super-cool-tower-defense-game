extends Projectile


var out_speed = GameData.projectiles.Fireball.projectile_speed
var out_piercing = GameData.projectiles.Fireball.projectile_piercing
var out_damage = GameData.projectiles.Fireball.projectile_damage
var out_effect = Globals.enemy_debuffs.Burning
var out_asset = preload("res://Assets/Towers/Projectiles/Fireball.png")

func _ready():
	_initialize_values(out_speed, out_piercing, out_damage, out_asset)
	$ExplosionRadius.damage = 0

func _on_impact(area):
	if area.is_in_group("enemies"):
		$ExplosionRadius/CollisionShape2D.disabled = false
		speed = 0.0
		$ExplosionRadius/Explosion.emitting = true
		$ExplosionRadius.damage = out_damage
		$Sprite.visible = false
		get_tree().create_timer(0.5).connect("timeout", self, "disable_hitbox")
		timer.start(0.6)
		
func disable_hitbox():
	$ExplosionRadius/CollisionShape2D.disabled = true
