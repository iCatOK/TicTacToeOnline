extends ColorRect
class_name Cell

@export var ocuppied_cell_color_first: Color
@export var ocuppied_cell_color_second: Color
@export var free_cell_color: Color
@export var row: int = 0
@export var col: int = 0

var is_occupied: bool = false

signal cell_ocuppied(cell: Cell)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Changes cell state. It is assumed that there is two players with certain ids.
func change_cell_state(player_identifier: String):
	var new_color: Color
	if player_identifier == Utils.FIRST_PLAYER_ID:
		new_color = ocuppied_cell_color_first
	elif player_identifier == Utils.SECOND_PLAYER_ID:
		new_color = ocuppied_cell_color_second
	else:
		push_error("Unexpected player id occured: %s" % player_identifier)
	is_occupied = true
	self.color = new_color

# Emmit signal and set itself if pressed
func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("ui_left_click"):
		emit_signal("cell_ocuppied", self)
		
