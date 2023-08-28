extends Control
class_name TicTacToeSession

# Editor vars
@export var rows_count = 3
@export var cols_count = 3

var label_default_color: Color = Color.from_string("fa3869", Color.RED)

# Private vars
var _max_turns_count: int
var _map: Array
var _players: Array

# State vars
var _current_player: PlayerData
var _current_player_index: int
var _current_turns_count: int
var _is_game_ended: bool

# Signals
signal end_game(winner: PlayerData)

func _ready():
	# Connect `cell_occupied` signals (for all cells)
	for cell in $SessionRoot/Map.get_children():
		cell.connect("cell_ocuppied", _on_cell_ocuppied)
		
	# Set up player names and labels
	_players = [
		PlayerData.new(Global.player_name, $SessionRoot/PlayerLabel),
		PlayerData.new(Global.opponent_name, $SessionRoot/OpponentLabel)
	]
	
	$SessionRoot/PlayerLabel.text = Global.player_name
	$SessionRoot/OpponentLabel.text = Global.opponent_name
	
	# Initialize first round
	initialize_new_game()
	
	# Set max turns count
	_max_turns_count = rows_count * cols_count


func _on_cell_ocuppied(cell: Cell):
	# If cell occupied then do nothing
	if cell.is_occupied or _is_game_ended:
		return
	
	# Debug coordinates
	print("Coords: %d %d" % [cell.row, cell.col])
	
	# Fill cell with marker of current player
	var current_turn_marker = _current_player.marker
	cell.change_cell_state(current_turn_marker)
	
	# Set player's turn on array for further checking
	_map[cell.row][cell.col] = current_turn_marker
	
	# Check winning condition
	var win = Utils.check_tic_tac_toe_map(_map, cell.row, cell.col)
	if win:
		print("Winner is: %s!" % _current_player.player_name)
		_is_game_ended = true
		emit_signal("end_game", _current_player)
		return
		
	# Increment turns count and check for draw
	_current_turns_count += 1
	if _current_turns_count == _max_turns_count:
		print("It's a draw!")
		_is_game_ended = true
		emit_signal("end_game", null)
		return
	
	change_player_after_turn()
	

# Changes current player id and index according to player list.
func change_player_after_turn():
	# Clear label highlighting
	_current_player.label.add_theme_color_override("font_color", label_default_color)
	
	_current_player_index += 1
	if _current_player_index > _players.size() - 1:
		_current_player_index = 0
	
	_current_player = _players[_current_player_index]
	
	# Highlight next player label
	_current_player.label.add_theme_color_override("font_color", Color.WHITE)
	
	print("%s turn!" % _current_player.player_name)
	

func initialize_new_game():
	# Create map
	_map = Utils.generate_2d_array(rows_count, cols_count)
	
	# Shuffle players
	_players.shuffle()
	
	# Set player markers
	_players[0].marker = Cell.CROSS_IDENTIFIER
	_players[1].marker = Cell.CIRCLE_IDENTIFIER
	
	# Set game variables
	_current_player = _players[_current_player_index]
	_current_player_index = 0
	_current_turns_count = 0
	_is_game_ended = false
	
	# Highlight current player label
	_current_player.label.add_theme_color_override("font_color", Color.WHITE)
	
	# Clear cells' UI
	for cell in $SessionRoot/Map.get_children():
		cell.reset_cell()
	
	# Set turn text
	print("%s turn!" % _current_player.player_name)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_result_dialog_play_again():
	initialize_new_game()
