tool
extends Node2D


var nodes = [
	Vector2(150, 150),
	Vector2(300, 300),
	Vector2(200, 400),
	Vector2(125, 500)
]

var current_state = null
var current_node = null

func _ready():
	change_state("selection")

func change_state(new_state_name):
	current_state = $states.get_node(new_state_name)
	current_state.railtrack = self
	if current_state.has_method('start'):
		current_state.start()

func _physics_process(delta):
	if current_state.has_method('process'):
		current_state.process(delta)

func _input(event):
	if current_state.has_method('input'):
		current_state.input(event)
		
func _draw():
	if current_state.has_method('draw'):
		current_state.draw()
	else:
		for i in range(len(nodes) - 1):
			draw_line(nodes[i], nodes[i+1], Color.red, 5)
		draw_line(nodes[len(nodes) - 1], nodes[0], Color.red, 5)
		
		if current_node != null:
			draw_circle(nodes[current_node], 10, Color.blue)

func get_closest_node_and_edge(mouse_position):
	var closest_node_index = 0
	var closest_distance = nodes[closest_node_index].distance_to(mouse_position)
	for i in range(1, len(nodes)):
		var new_distance = nodes[i].distance_to(mouse_position)
		if new_distance < closest_distance:
			closest_node_index = i
			closest_distance = new_distance

	return [closest_node_index, null]

func get_previous_index(current_index):
	if current_index > 0:
		current_index = current_index - 1
	else:
		current_index = len(nodes) - 1

func get_next_index(current_index):
	if current_index < len(nodes) - 1:
		current_index = current_index + 1
	else:
		current_index = 0

func highlight_node(node_index):
	if node_index != current_node:
		current_node = node_index
	update()

func select_current_node():
	if current_node != null:
		print("Selected!")
