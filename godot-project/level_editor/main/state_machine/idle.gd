extends Node2D

var state_machine = null
var level_editor = null


func _on_add_vertices_button_pressed():
	state_machine.set_current_state('add_vertices')
