extends TextureRect
class_name TextureMarker

@export var circle_texture: Texture
@export var cross_texture: Texture
@export var free_cell_texture: Texture

var texture_map = {}

# Changes cell state. It is assumed that there is two players with certain ids.
func change_cell_state(player_identifier: String):
	var new_state: Texture = texture_map[player_identifier]
	if (new_state == null):
		push_warning("State of Texture Marker is null")
	self.texture = new_state


func set_free_cell():
	self.texture = free_cell_texture


# Called when the node enters the scene tree for the first time.
func _ready():
	set_free_cell()
	texture_map = {
		Cell.CROSS_IDENTIFIER: cross_texture,
		Cell.CIRCLE_IDENTIFIER: circle_texture
	}
