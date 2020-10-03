extends Node

var railtrack = null

func start():
	$buttons_container.visible = true
	$buttons_container.set_global_position(railtrack.to_global(railtrack.nodes[railtrack.current_node]) + Vector2(0, 15))


func _on_remove_button_pressed():
	$buttons_container.visible = false
	railtrack.remove_current_node()
	railtrack.change_state("selection")


func _on_cancel_button_pressed():
	$buttons_container.visible = false
	railtrack.change_state("selection")
