extends Node

var state_machine = null
var railtrack = null

func start():
	$node_deletion_menu.visible = true
	var vertex_pos = railtrack.to_global(railtrack.get_node('path').get_nodes()[railtrack.get_node('path').current_node].position)
	if vertex_pos.y < 600:
		$node_deletion_menu.set_global_position(vertex_pos + Vector2(0, 15))
	else:
		$node_deletion_menu.set_global_position(vertex_pos + Vector2(0, -80))


func _on_node_deletion_menu_confirmed():
	$node_deletion_menu.visible = false
	railtrack.remove_current_node()
	state_machine.change_state("selection")


func _on_node_deletion_menu_cancelled():
	$node_deletion_menu.visible = false
	state_machine.change_state("selection")


func end():
	$node_deletion_menu.visible = false
