extends TextureRect
class_name TextureMarker

@export var ocuppied_cell_texture_first: Texture
@export var ocuppied_cell_texture_second: Texture
@export var free_cell_texture: Texture

# Changes cell state. It is assumed that there is two players with certain ids.
func change_cell_state(player_identifier: String):
	var new_state: Texture
	if player_identifier == Utils.FIRST_PLAYER_ID:
		new_state = ocuppied_cell_texture_first
	elif player_identifier == Utils.SECOND_PLAYER_ID:
		new_state = ocuppied_cell_texture_second
	else:
		push_error("Unexpected player id occured: %s" % player_identifier)
	self.texture = new_state


func set_free_cell():
	self.texture = free_cell_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = free_cell_texture
