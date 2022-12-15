tool
extends EditorScript

var height
var width
var matrix_row
var random = RandomNumberGenerator.new()

# EMPTY MATRIX VER (1)
var empty_matrix = []

func make_empty_matrix(height, width):
	for i in height:
		matrix_row = []
		for j in width:
			matrix_row.append(0)
		empty_matrix.append(matrix_row)
		
func get_direction():
	# [x,y] coordinates
	# [up, right, left, down]
	var direction_arr = [[0,1], [1,0], [-1,0], [0,-1]]
	var direction = direction_arr[randi()%4]
	
	return direction

func reflect_matrix_move(x, y, matrix_len):
	"""
		Maps the directional move from orignal matrix to the flipped matrix.
	"""
	var cur_x = matrix_len - y - 1
	var cur_y = x
	
	return [cur_x, cur_y]
	
func mark_tile(tile_loc, matrix, marker):
	var x_cord = tile_loc[0]
	var y_cord = tile_loc[1]
	
	matrix[x_cord][y_cord] = marker

func make_path(matrix, start_tile):
	""" 
		Creatres a path in an empty matrix.
		start_tile is the starting point for the enemy.
		Maintain matrices:
			- Original (for tracking directional changes)
			- Flipped (to render the map)
	"""
	var tile_cnt = 1 # for logic later on
	
	# on creation mark the entrance tile as "A".
	var flipped_arr = reflect_matrix_move(start_tile[0], start_tile[1], len(matrix))
	mark_tile(flipped_arr, matrix, "A")
	
	# maintains unflipped matrix
	var original_tile = start_tile
	
	var gen_map = true
	var gen_map_cnt = 0
	
	while gen_map_cnt < 2:
		
		var path_direction = get_direction()
		
		print(path_direction)
		
		random.randomize()
		var path_length = random.randi_range(3,6)
		
		print(path_length)
	
		for i in range(0, path_length):
				
			var tile_marker = "X"
			
			# make move on original matrix
			original_tile[0] += path_direction[0]
			original_tile[1] += path_direction[1]
			
			# reflect move on "flipped matrix"
			flipped_arr = reflect_matrix_move(original_tile[0], original_tile[1], len(matrix))
			mark_tile(flipped_arr, matrix, tile_marker)
			
			tile_cnt += 1
		
		gen_map_cnt += 1
	
func _run():
	make_empty_matrix(10,10)

	make_path(empty_matrix, [0,3])
	
	#prints matrix for visualization
	print()
	for row in empty_matrix:
		print(row)





