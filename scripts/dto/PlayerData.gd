# Class that represents player's data
extends Node2D
class_name PlayerData

var player_name: String
var label: Label
var marker: String


func _init(player_name: String, label: Label):
	self.player_name = player_name
	self.label = label

