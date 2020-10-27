extends Node

var railtrack = null

func start():
	$node_deletion_menu.visible = true
	var vertex_pos = railtrack.to_global(railtrack.nodes[railtrack.current_node])
	if vertex_pos.y < 600:
		$node_deletion_menu.set_global_position(vertex_pos + Vector2(0, 15))
	else:
		$node_deletion_menu.set_global_position(vertex_pos + Vector2(0, -80))


func _on_node_deletion_menu_confirmed():
	$node_deletion_menu.visible = false
	railtrack.remove_current_node()
	railtrack.change_state("selection")


func _on_node_deletion_menu_cancelled():
	$node_deletion_menu.visible = false
	railtrack.change_state("selection")


func end():
	$node_deletion_menu.visible = false
