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

var Tile = {
	0: "Empty",
	1: "Full"
}


# EMPTY MATRIX VER (1)
var empty_matrix = []
func make_empty_matrix(height, width):
	for i in height:
		matrix_row = []
		for j in width:
			matrix_row.append(0)
		empty_matrix.append(matrix_row)
		
func get_direction():
	# [x,y]
	# [up, right, left, down]
	var direction_arr = [[0,1], [1,0], [-1,0], [0,-1]]
	var direction = direction_arr[randi()%4]
	return direction
	
func make_path(matrix, start_tile):
	""" 
		Runs on empty matrix
		v.1
	"""
	# since the matricie is flipped
	# we want to set the x as the y and vice versa
	var cur_x = len(matrix) - start_tile[1] - 1
	var cur_y = start_tile[0]
	
	#var cur_x = start_tile[0]
	#var cur_y = start_tile[1]
	
	var cur_direction = get_direction()
	print(cur_direction)
	
	print("Start tile x: ", start_tile[0], " y: ", start_tile[1])
	print("Current cords x: ", cur_x, " y: ", cur_y)
	matrix[cur_x][cur_y] = "M"
	
	cur_x += cur_direction[0]
	cur_y += cur_direction[1]
	print("Post x: ", cur_x, " y: ", cur_y)
	print("Post start tile x: ", start_tile[0] + cur_direction[0], " y: ", start_tile[1] + cur_direction[1])
	
	"""
	for i in range(0,1):
		var cur_direction = get_direction()
		cur_x += cur_direction[0]
		cur_y += cur_direction[1]
	"""
		
	
func _run():
	make_matrix(5,5)
	make_empty_matrix(5,5)
	#make_path(map_matrix)
	
	make_path(empty_matrix, [0,3])
	for row in empty_matrix:
		print(row)













