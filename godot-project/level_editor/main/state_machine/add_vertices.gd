extends Node2D

var level_editor = null
var main = null
var state_machine = null

func start():
	level_editor.get_node('tools_container').visible = false
	main.get_path().open()

func input(event):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed and not Rect2($add_vertices_exit_button.rect_position, $add_vertices_exit_button.rect_size).has_point(event.position):
		var mouse_position = main.get_path().to_local(event.position)
		level_editor.add_path_node(mouse_position)


func _on_add_vertices_exit_button_pressed():
	main.get_path().close()
	state_machine.set_current_state('idle')
