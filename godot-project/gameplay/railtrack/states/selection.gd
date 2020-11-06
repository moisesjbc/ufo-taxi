extends Node

var state_machine = null
var railtrack = null
export var node_selection_distance: int = 50
export var edge_selection_distance: int = 100

func input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		var mouse_position = railtrack.get_node('path').to_local(event.position)
		var node_index = railtrack.get_node('path').get_closest_node(mouse_position)
		if node_index != null:
			var node_position = railtrack.get_node('path').nodes[node_index]
			if mouse_position.distance_to(node_position) < node_selection_distance:
				railtrack.get_node('path').highlight_node(node_index)
			else:
				railtrack.get_node('path').highlight_node(null)
				
				var closest_edge = railtrack.get_node('path').get_closest_edge(mouse_position, node_index, edge_selection_distance)
				railtrack.get_node('path').highlight_edge(closest_edge)
				
		if event is InputEventScreenTouch and event.pressed:
			railtrack.confirm_current_selection()
		
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		railtrack.confirm_current_selection()
