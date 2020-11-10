extends Node2D

var level_editor = null
var state_machine = null

func start():
	level_editor.get_node('path').open()

func input(event):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed and not Rect2($add_vertices_exit_button.rect_position, $add_vertices_exit_button.rect_size).has_point(event.position):
		var mouse_position = level_editor.get_node('path').to_local(event.position)
		level_editor.get_node('path').push_node(mouse_position)


func _on_add_vertices_exit_button_pressed():
	level_editor.get_node('path').close()
	state_machine.set_current_state('idle')
