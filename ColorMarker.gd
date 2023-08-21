extends ColorRect
class_name ColorMarker

@export var ocuppied_cell_color_first: Color
@export var ocuppied_cell_color_second: Color
@export var free_cell_color: Color

# Changes cell state. It is assumed that there is two players with certain ids.
func change_cell_state(player_identifier: String):
	var new_state: Color
	if player_identifier == Utils.FIRST_PLAYER_ID:
		new_state = ocuppied_cell_color_first
	elif player_identifier == Utils.SECOND_PLAYER_ID:
		new_state = ocuppied_cell_color_second
	else:
		push_error("Unexpected player id occured: %s" % player_identifier)
	self.color = new_state


# Called when the node enters the scene tree for the first time.
func _ready():
	self.color = free_cell_color
