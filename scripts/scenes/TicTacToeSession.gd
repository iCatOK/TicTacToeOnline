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
var _current_player_index: int
var _current_turns_count: int
var _is_game_ended: bool

func _ready():
	# Connect `cell_occupied` signals (for all cells)
	for cell in $Map.get_children():
		cell.connect("cell_ocuppied", _on_cell_ocuppied)
		
	initialize_new_game()
	
	# Set max turns count
	_max_turns_count = rows_count * cols_count


func _on_cell_ocuppied(cell: Cell):
	# If cell occupied then do nothing
	if cell.is_occupied or _is_game_ended:
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
		$PlayerLabel.text = "Winner is: %s!" % _current_player_id
		_is_game_ended = true
		$ResetButton.disabled = false
		return
		
	# Increment turns count and check for draw
	_current_turns_count += 1
	if _current_turns_count == _max_turns_count:
		$PlayerLabel.text = "It's a draw!"
		_is_game_ended = true
		$ResetButton.disabled = false
		return
	
	change_player_after_turn()
	

# Changes current player id and index according to player list.
func change_player_after_turn():
	_current_player_index += 1
	if _current_player_index > _players.size() - 1:
		_current_player_index = 0
	_current_player_id = _players[_current_player_index]
	$PlayerLabel.text = "%s\nturn!" % _current_player_id
	

func initialize_new_game():
	# Create map
	_map = Utils.generate_2d_array(rows_count, cols_count)
	
	# Disable reset button
	$ResetButton.disabled = true
	
	# Create players
	_players = [Utils.FIRST_PLAYER_ID, Utils.SECOND_PLAYER_ID]
	
	# Set game variables
	_current_player_id = _players[_current_player_index]
	_current_player_index = 0
	_current_turns_count = 0
	_is_game_ended = false
	
	# Clear cells' UI
	for cell in $Map.get_children():
		cell.reset_cell()
	
	# Set turn text
	$PlayerLabel.text = "%s\nturn!" % _current_player_id


func _on_reset_button_pressed():
	initialize_new_game()


func _on_exit_button_pressed():
	get_tree().quit()
