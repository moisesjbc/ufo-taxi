extends Node

var state_machine = null
var railtrack = null

func start():
	$remove_button.visible = true
	var vertex_pos = railtrack.to_global(railtrack.get_node('path').get_nodes()[railtrack.get_node('path').current_node].position)
	if vertex_pos.y < 600:
		$remove_button.set_global_position(vertex_pos + Vector2(0, 15))
	else:
		$remove_button.set_global_position(vertex_pos + Vector2(0, -80))


func _on_remove_button_confirmed():
	$remove_button.visible = false
	railtrack.remove_current_node()
	state_machine.change_state("selection")


func _on_remove_button_cancelled():
	$remove_button.visible = false
	railtrack.get_node('path').highlight_node(null)
	state_machine.change_state("selection")


func end():
	$remove_button.visible = false
