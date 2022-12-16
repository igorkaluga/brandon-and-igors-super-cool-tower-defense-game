tool
extends EditorScript

var height
var width
var matrix_row
var random = RandomNumberGenerator.new()
var map_size = 10

# EMPTY MATRIX VER (1)
var empty_matrix = []

func make_empty_matrix(height, width):
	for i in height:
		matrix_row = []
		for j in width:
			matrix_row.append(" ")
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
	
func check_reverse_dir(prev_dir, cur_dir):
	# [x,y] coordinates
	# [up, right, left, down]
	# [[0,1], [1,0], [-1,0], [0,-1]]
	
	var direction_arr = [[0,1], [1,0], [-1,0], [0,-1]]
	var reverse_direction_arr = [[0,-1], [-1,0], [1,0], [0,1]]
	
	
	if prev_dir != null:
		var prev_direction_index = direction_arr.find(prev_dir)
		if reverse_direction_arr[prev_direction_index] == cur_dir:
			return true
			
	return false
	
func check_out_of_bounds(path_length, path_dir, cur_tile, map_size):
	"""
		Checks if the path to be generated path will put the path out of map bounds.
		Adds the path length to the correct (x,y) coordinate of the current tile.
		If out of bounds then returns true, otherwise false
		
	"""
	var cur_plus_len = path_length
	
	if path_dir[0] != 0:
		# move on x axis
		cur_plus_len = cur_tile[0] + (path_dir[0] * path_length)
	else:
		# move on y axis
		cur_plus_len = cur_tile[1] + (path_dir[1] * path_length)
	
	if cur_plus_len >= map_size - 1 or cur_plus_len <= 0: # -1 since matrix is 0 indexed
		return true
	return false
	
func check_on_map_edge(position, map_size):
	if 0 in position or map_size - 1 in position:
		return true
	return false

func make_path(matrix, start_tile):
	""" 
		Creatres a path in an empty matrix.
		start_tile is the starting point for the enemy.
		Maintain matrices:
			- Original (for tracking directional changes, how we view the map)
			- Flipped (to render the map)
	"""
	var tile_cnt = 1 # for logic later on
	
	# on creation mark the entrance tile as "A".
	var flipped_arr = reflect_matrix_move(start_tile[0], start_tile[1], len(matrix))
	mark_tile(flipped_arr, matrix, "A")
	
	# maintains unflipped matrix
	var original_tile = start_tile
	var current_flipped_tile # flipped
	
	var prev_path_dir
	
	var gen_map = true
	var gen_map_cnt = 0
	
	while gen_map_cnt < 1:
		
		var path_direction = get_direction()
		
		# check if new path is a reverse of the previous path.
		var reverse_path = check_reverse_dir(prev_path_dir, path_direction)

		while reverse_path:
			path_direction = get_direction()
			reverse_path = check_reverse_dir(prev_path_dir, path_direction)
		
		random.randomize()
		var path_length = random.randi_range(2,4)
		
		# check for out of bounds pathing.
		var out_of_bounds = check_out_of_bounds(path_length, path_direction, original_tile, map_size)
		
		
		
		
		while out_of_bounds:
			# if original tiles is not near the map border, then get new length,
			# otherwise, get new direction entirely.
			original_tile = [1,0]
			var on_map_edge = check_on_map_edge(original_tile, map_size)
			
			out_of_bounds = check_out_of_bounds(path_length, path_direction, original_tile, map_size)
			path_length = random.randi_range(1,4)
			break
		#break
		
		print("path len: ", path_length)
		print("path dir: ", path_direction)
		print()
	
		# marks the tiles on the matrix in range of 0, path_length in generated direction.
		for i in range(0, path_length):
				
			var tile_marker = "X"
			
			# make move on original matrix
			original_tile[0] += path_direction[0]
			original_tile[1] += path_direction[1]
			
			# reflect move on "flipped matrix"
			flipped_arr = reflect_matrix_move(original_tile[0], original_tile[1], len(matrix))
			mark_tile(flipped_arr, matrix, tile_marker)
			
			current_flipped_tile = flipped_arr # updates current tile
			
			tile_cnt += 1 # counts total tiles on map so far
			
		prev_path_dir = path_direction
		gen_map_cnt += 1
	
func _run():
	
	make_empty_matrix(map_size, map_size)

	make_path(empty_matrix, [4,4])
	
	#prints matrix for visualization purposes
	print()
	for row in empty_matrix:
		print(row)





