extends Node

var railtrack = null

func start():
	$buttons_container.visible = true
	var vertex_pos = railtrack.to_global(railtrack.nodes[railtrack.current_node])
	if vertex_pos.y < 600:
		$buttons_container.set_global_position(vertex_pos + Vector2(0, 15))
	else:
		$buttons_container.set_global_position(vertex_pos + Vector2(0, -80))


func _on_remove_button_pressed():
	$buttons_container.visible = false
	railtrack.remove_current_node()
	railtrack.change_state("selection")


func _on_cancel_button_pressed():
	$buttons_container.visible = false
	railtrack.change_state("selection")
