tool
extends EditorScript

var height
var width
var map_matrix = []
var matrix_row
var rng = RandomNumberGenerator.new()

# FILLED MATRIX VER (1)
func make_matrix(height, width):
	"""
		Generates height x width matracie of ones and zeros.
		1 - taken tile
		2 - empty tile
	"""
	for i in height:
		matrix_row = []
		var one_counter = 0
		
		for j in width:
			var tile = round(randf())
			
			#tile count logic
			if tile == 1:
				one_counter += 1
			if one_counter > 5:
				matrix_row.append(0)
				
			else:
				matrix_row.append(tile)
				
		map_matrix.append(matrix_row)
