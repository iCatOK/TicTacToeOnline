extends Control
class_name ResultDialog

signal play_again

func show_dialog(data: PlayerData):
	if data == null:
		$ColorRect/VBoxContainer/WinnerLabel.text = "It's a draw!"
	else:
		$ColorRect/VBoxContainer/WinnerLabel.text = "%s wins!" % data.player_name
	visible = true


func _on_play_again_button_pressed():
	visible = false
	emit_signal("play_again")
