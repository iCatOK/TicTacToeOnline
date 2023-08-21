# Contains utility methods for tic tac toe game

extends Node
class_name Utils

const FIRST_PLAYER_ID = "P1"
const SECOND_PLAYER_ID = "P2"


static func generate_2d_array(row_count: int, col_count: int) -> Array:
	var matrix = []
	for x in range(row_count):
		matrix.append([])
		matrix[x]=[]
		for y in range(col_count):
			matrix[x].append([])
			matrix[x][y]=""
	return matrix
	

# Checks the diagonals (if turn was there), col and row of current turn
static func check_tic_tac_toe_map(map_array: Array, row: int, col: int):
	var row_count = map_array.size()
	var col_count = map_array[row].size()
	
	# Check row
	var row_win = true
	var first_cell_in_row = map_array[row][0]
	for i in range(1, col_count):
		var another_cell_in_row = map_array[row][i]
		if another_cell_in_row != first_cell_in_row:
			row_win = false
			break
	if row_win:
		print("[check map] Winning by row of player %s" % first_cell_in_row)
		return true
	
	# Check col
	var col_win = true
	var first_cell_in_col = map_array[0][col]
	for i in range(1, row_count):
		var another_cell_in_row = map_array[i][col]
		if another_cell_in_row != first_cell_in_col:
			col_win = false
			break
	if col_win:
		print("[check map] Winning by col of player %s" % first_cell_in_col)
		return true
	
	# Check left diag
	if row == col:
		var diag_win = true
		var first_cell_in_diag = map_array[0][0]
		for i in range(1, row_count):
			var another_cell_in_diag = map_array[i][i]
			if another_cell_in_diag != first_cell_in_diag:
				diag_win = false
				break
		if diag_win:
			print("[check map] Winning by diag left of player %s" % first_cell_in_diag)
			return true
	
	# Check right diag (consider that map is a square)
	if row == map_array.size() - 1 - col:
		var diag_win = true
		var first_cell_in_diag = map_array[row_count-1][0]
		for i in range(1, -1, -1):
			var another_cell_in_diag = map_array[i][col_count-1-i]
			if another_cell_in_diag != first_cell_in_diag:
				diag_win = false
				break
		if diag_win:
			print("[check map] Winning by diag right of player %s" % first_cell_in_diag)
			return true
	
	# Nobody won
	return false
