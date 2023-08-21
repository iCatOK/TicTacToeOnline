extends Control
class_name TicTacToeSession

# Editor vars
@export var rows_count = 3
@export var cols_count = 3

# Private vars
var _max_turns_count: int
var _map: Array
var _players: Array

# State vars
var _current_player_id: String
var _current_player_index: int = 0
var _current_turns_count: int = 0

func _ready():
	# Connect `cell_occupied` signals (for all cells)
	for cell in $Map.get_children():
		cell.connect("cell_ocuppied", _on_cell_ocuppied)
		
	# Create map
	_map = Utils.generate_2d_array(rows_count, cols_count)
	
	# Set max turns count
	_max_turns_count = rows_count * cols_count
	
	# Create players and set turn
	_players = [Utils.FIRST_PLAYER_ID, Utils.SECOND_PLAYER_ID]
	_current_player_id = _players[_current_player_index]
	print("Turn of player '%s'!" % _current_player_id)


func _on_cell_ocuppied(cell: Cell):
	# If cell occupied then do nothing
	if cell.is_occupied:
		return
	
	# Debug coordinates
	print("Coords: %d %d" % [cell.row, cell.col])
	
	# Fill cell and set new player after turn
	cell.change_cell_state(_current_player_id)
	
	# Set player's turn on array for further checking
	_map[cell.row][cell.col] = _current_player_id
	
	# Check winning condition
	var win = Utils.check_tic_tac_toe_map(_map, cell.row, cell.col)
	if win:
		print("Winner is: %s!" % _current_player_id)
		
	# Increment turns count and check for draw
	_current_turns_count += 1
	if _current_turns_count == _max_turns_count:
		print("It's a draw!")
	
	change_player_after_turn()
	

# Changes current player id and index according to player list.
func change_player_after_turn():
	_current_player_index += 1
	if _current_player_index > _players.size() - 1:
		_current_player_index = 0
	_current_player_id = _players[_current_player_index]
	print("Turn of player '%s'!" % _current_player_id)
