extends Node


var forest_enemies = ["BasicEnemy", "Troll"]

const round_multiplier = 10

func create_wave_data(wave_number):
	# Each wave will have a certain amount of points to buy enemies with
	# Most enemies cost a single point, but some enemies cost more
	var wave_points = wave_number * round_multiplier
	var wave = []
	while wave_points > 0:
		wave.append(["BasicEnemy", 0.5])
		wave_points -= 1
		
	return wave


