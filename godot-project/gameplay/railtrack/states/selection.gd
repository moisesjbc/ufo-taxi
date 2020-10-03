extends Node

var railtrack = null
export var node_selection_distance: int = 50

func input(event):
	if event is InputEventMouseMotion:
		var mouse_position = railtrack.to_local(event.position)
		var result = railtrack.get_closest_node_and_edge(mouse_position)
		if result:
			var node_index = result[0]
			var edge_index = result[1]
			
			var node_position = railtrack.nodes[node_index]
			if mouse_position.distance_to(node_position) < node_selection_distance:
				railtrack.highlight_node(node_index)
			else:
				railtrack.highlight_node(null)
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and railtrack.current_node != null:
			railtrack.select_current_node()
