extends Node

var railtrack = null
export var node_selection_distance: int = 50
export var edge_selection_distance: int = 100

func input(event):
	if event is InputEventMouseMotion:
		var mouse_position = railtrack.to_local(event.position)
		var node_index = railtrack.get_closest_node(mouse_position)
		if node_index != null:
			var node_position = railtrack.nodes[node_index]
			if mouse_position.distance_to(node_position) < node_selection_distance:
				railtrack.highlight_node(node_index)
			else:
				railtrack.highlight_node(null)
				
				var closest_edge = railtrack.get_closest_edge(mouse_position, node_index, edge_selection_distance)
				railtrack.highlight_edge(closest_edge)
				
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		railtrack.confirm_current_selection()
