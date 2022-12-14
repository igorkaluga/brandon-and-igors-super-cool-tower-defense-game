tool
extends EditorScript

var height
var width
var matrix_row
var random = RandomNumberGenerator.new()
var map_size = 20
var direction_arr = [[0,1], [1,0], [-1,0], [0,-1]]
var reverse_direction_arr = [[0,-1], [-1,0], [1,0], [0,1]]

# EMPTY MATRIX VER (1)
var empty_matrix = []

func make_empty_matrix(height, width):
	for i in height:
		matrix_row = []
		for j in width:
			matrix_row.append(" ")
		empty_matrix.append(matrix_row)
		
func get_direction(valid_directions):
	# [x,y] coordinates
	# [up, right, left, down]
	var array_len = len(valid_directions)
	var direction = valid_directions[randi()%array_len]
	
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
	
func get_reverse_dir(cur_dir):
	var reverse_direction_index = direction_arr.find(cur_dir)
	
	return reverse_direction_arr[reverse_direction_index]
	
func get_valid_directions(cur_pos, prev_dir, map_size):
	
	var valid_dir_arr = []
	var reverse_prev_dir
	
	if prev_dir != null:
		reverse_prev_dir = get_reverse_dir(prev_dir)

	for dir in direction_arr:
		if reverse_prev_dir == dir:
			# skips previous direction so reverse path case doesnt occur
			continue
			
		if cur_pos[0] + dir[0] < 0 or cur_pos[0] + dir[0] > map_size - 1:
			print("invalid x: ", dir)
			# invalid x-axis
			continue
		elif cur_pos[1] + dir[1] < 0 or cur_pos[1] + dir[1] > map_size - 1:
			# invalid y-axis
			print("invalid y: ", dir)
			continue
		else:
			print(dir)
			valid_dir_arr.append(dir)
			
	return valid_dir_arr
	
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
	
	if cur_plus_len >= map_size - 1 or cur_plus_len < 0: # -1 since matrix is 0 indexed
		return true
	return false
	
func check_on_map_edge(position, map_size):
	"""
		If the current position is on any of the maps edges then return true.
		
		> check_on_map_edge([0,2], 10)
		true
		> check_on_map_edge([4,9], 10)
		true
	"""
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
	random.randomize()
	
	# on creation mark the entrance tile as "A".
	var flipped_arr = reflect_matrix_move(start_tile[0], start_tile[1], len(matrix))
	mark_tile(flipped_arr, matrix, "A")
	
	# maintains unflipped matrix
	var original_tile = start_tile
	var current_flipped_tile # flipped
	
	var prev_path_dir
	
	# var gen_map = true
	var gen_map_cnt = 0
	
	while gen_map_cnt < 10:
		
		var valid_dir_array = get_valid_directions(original_tile, prev_path_dir, map_size)
		
		print(prev_path_dir)
		print(valid_dir_array)
		
		var path_direction = get_direction(valid_dir_array)
		var path_length = random.randi_range(3,8) # make get_path_len function
		
		# out of bounds checker
		var is_out_of_bounds = check_out_of_bounds(path_length, path_direction, original_tile, map_size)
		
		var timeout_fix = 0
		while is_out_of_bounds:
			print(timeout_fix)
			if timeout_fix >= 20:
				break
			path_length = random.randi_range(1,4)
			print("trying path_len = ", path_length)
			is_out_of_bounds = check_out_of_bounds(path_length, path_direction, original_tile, map_size)
			print("is_out_of_bounds: ", is_out_of_bounds)
			timeout_fix += 1
		
		print("new path_len: ", path_length)
		print("path dir: ", path_direction)
	
		# marks the tiles on the matrix
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
		print()
	
func _run():

	print("\n=============================================")
	
	make_empty_matrix(map_size, map_size)

	make_path(empty_matrix, [0,9])
	
	#prints matrix for visualization purposes
	print()
	for row in empty_matrix:
		print(row)
		
		
		
### FUNCTIONS NO LONGER IN USE

func check_reverse_dir(prev_dir, cur_dir):
	""" No longer in use, delete later. Keeping for now just in case """
	# [x,y] coordinates
	# [up, right, left, down]
	# [[0,1], [1,0], [-1,0], [0,-1]]
	if prev_dir != null:
		var prev_direction_index = direction_arr.find(prev_dir)
		if reverse_direction_arr[prev_direction_index] == cur_dir:
			return true
	return false
	
func get_valid_dir_arr(invalid_arr):
	""" No longer in use. Keeping just in case. """
	var valid_dir_arr = []
	
	for dir in direction_arr:
		if not dir in invalid_arr:
			valid_dir_arr.append(dir)

	return valid_dir_arr
