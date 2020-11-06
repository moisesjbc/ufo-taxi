extends Node2D

var closed = true
var nodes = []
var current_node = null
var current_edge = null

func set_nodes(nodes):
	self.nodes = nodes.duplicate()

func _draw():
	for i in range(len(nodes) - 1):
		draw_line(nodes[i], nodes[i+1], get_edge_color(i), 5)
	if closed:
		draw_line(nodes[len(nodes) - 1], nodes[0], get_edge_color(len(nodes) - 1), 5)
	
	if current_node != null:
		draw_circle(nodes[current_node], 10, Color.blue)

func get_edge_color(edge_index):
	if edge_index != current_edge:
		return Color.aquamarine
	else:
		return Color.blue

func get_closest_node(mouse_position):
	var closest_node_index = 0
	var closest_distance = nodes[closest_node_index].distance_to(mouse_position)
	for i in range(1, len(nodes)):
		var new_distance = nodes[i].distance_to(mouse_position)
		if new_distance < closest_distance:
			closest_node_index = i
			closest_distance = new_distance

	return closest_node_index
	
func get_closest_edge(mouse_position, ref_node, max_distance):
	var next_node = nodes[get_next_index(ref_node)]
	var previous_node = nodes[get_previous_index(ref_node)]
	var current_node = nodes[ref_node]

	var next_pos_multiplier = 0.5
	var previous_pos_multiplier = 0.5
	var next_pos = Vector2((current_node.x + next_node.x) * next_pos_multiplier, (current_node.y + next_node.y) * next_pos_multiplier)
	var previous_pos = Vector2((previous_node.x + current_node.x) * previous_pos_multiplier, (previous_node.y + current_node.y) * previous_pos_multiplier)

	var distance_to_next_pos = mouse_position.distance_to(next_pos)
	var distance_to_previous_pos = mouse_position.distance_to(previous_pos)
	
	if distance_to_next_pos < distance_to_previous_pos:
		if distance_to_next_pos < max_distance:
			return ref_node
	else:
		if distance_to_previous_pos < max_distance:
			return get_previous_index(ref_node)
	return null

func get_previous_index(current_index):
	if current_index > 0:
		return current_index - 1
	else:
		return len(nodes) - 1

func get_next_index(current_index):
	if current_index < len(nodes) - 1:
		return current_index + 1
	else:
		return 0

func highlight_node(node_index):
	if node_index != current_node:
		current_edge = null
		current_node = node_index
		update()
		
func highlight_edge(edge_index):
	if edge_index != current_edge:
		current_node = null
		current_edge = edge_index
		update()
	
func push_node(new_position):
	nodes.push_back(new_position)
	update()

func close():
	closed = true
	update()
