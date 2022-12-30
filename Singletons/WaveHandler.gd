extends Node

signal merchant_round

var forest_enemies = {
	"tier1": {
		"BasicEnemy": preload("res://Scenes/Enemies/BasicEnemy.tscn"),
		"Spider": preload("res://Scenes/Enemies/Forest_Enemies/Spider.tscn")
		},
	"tier2": {
		"Goblin": preload("res://Scenes/Enemies/Forest_Enemies/Goblin.tscn"),
		},
	"tier3": {
		"Troll": preload("res://Scenes/Enemies/Forest_Enemies/Troll.tscn"),
		},
	"tier4": {
		"Ent": preload("res://Scenes/Enemies/Forest_Enemies/Ent.tscn")
		}
	}

var npcs = {
	"merchants": {
		"RatMerchant": preload("res://Scenes/NPCs/Merchant.tscn"),
		"CarriageMerchant": preload("res://Scenes/NPCs/Carriage.tscn")
	}
}

const round_multiplier = 2
var rng = RandomNumberGenerator.new()

func create_wave_data(wave_number):

	print("Creating wave for wave: ", GameData.current_wave)
	var wave_points = pow(wave_number, round_multiplier)
	if wave_points < 10:
		wave_points = 10
	print("This wave has ", wave_points, " wave_points")
	
	var wave = []
	var new_enemy
	var new_enemy_tier
	rng.randomize()
	if GameData.current_wave % 10 == 1:
		wave.append(npcs.merchants.RatMerchant.instance())
		emit_signal("merchant_round", npcs.merchants.RatMerchant)
		return wave

	Globals.add_tower("FireTower")
	Globals.add_tower("IceTower")
	# Each wave will have a certain amount of points to buy enemies with
	# Most enemies cost a single point, but some enemies cost mor
	while wave_points > 0:
		var chosen_enemy
		if wave_points >= 100:
			new_enemy_tier = "tier3"
			chosen_enemy = choose_enemy(forest_enemies.tier3.keys())
			new_enemy = forest_enemies.tier3[chosen_enemy]
			wave_points -= 3
		elif wave_points >= 50:
			new_enemy_tier = "tier2"
			chosen_enemy = choose_enemy(forest_enemies.tier2.keys())
			new_enemy = forest_enemies.tier2[chosen_enemy]
			wave_points -= 2
		else:
			new_enemy_tier = "tier1"
			chosen_enemy = choose_enemy(forest_enemies.tier1.keys())
			new_enemy = forest_enemies.tier1[chosen_enemy]
			wave_points -= 1
			
		var enemy = new_enemy.instance()
		enemy.init(Globals.enemy_tier_stats[new_enemy_tier])
		wave.push_front(enemy)

	wave.shuffle()
	return wave

func choose_enemy(enemy_array):
	return enemy_array[randi() % enemy_array.size()]

