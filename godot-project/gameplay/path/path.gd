"""
Copyright 2020-2021 Moisés J. Bonilla Caraballo (moisesjbc)

This file is part of "UFO taxi!".

"UFO taxi!" is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

"UFO taxi!" is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with "UFO taxi!".  If not, see <https://www.gnu.org/licenses/>.
"""

extends Node2D

var closed = true
var current_node = null
var current_edge = null
onready var node_scene = preload('res://gameplay/path/node/node.tscn')
var edges_ref_points = []

func set_nodes(nodes_positions, on_object_selected_target = null, on_object_selected_callback = null):
	for node in get_nodes():
		node.free()
		
	for node_position in nodes_positions:
		add_node(node_position, null, on_object_selected_target, on_object_selected_callback)
		
	update()
	
func generate_edge_ref_points(edge_index, insert=false):
	var next_node = get_nodes()[get_next_index(edge_index)].global_position
	var current_node_position = get_nodes()[edge_index].global_position	

	var edge_ref_points = []
	for multiplier in [0.3, 0.5, 0.7]:
		edge_ref_points.append(Vector2(current_node_position.x + (next_node.x - current_node_position.x) * multiplier, current_node_position.y + (next_node.y - current_node_position.y) * multiplier))
	if edge_index < len(edges_ref_points):
		if insert:
			edges_ref_points.insert(edge_index, edge_ref_points)
		else:
			edges_ref_points[edge_index] = edge_ref_points
	else:
		edges_ref_points.push_back(edge_ref_points)
		
func get_nodes():
	return get_children()

func _draw():
	for i in range(len(get_nodes()) - 1):
		draw_line(get_nodes()[i].global_position, get_nodes()[i+1].global_position, get_edge_color(i), 5)
	if closed and len(get_nodes()):
		draw_line(get_nodes()[len(get_nodes()) - 1].global_position, get_nodes()[0].global_position, get_edge_color(len(get_nodes()) - 1), 5)

func get_edge_color(edge_index):
	if edge_index != current_edge:
		return Color.aquamarine
	else:
		return Color.blue

func get_closest_node(mouse_position):
	var closest_node_index = 0
	var closest_distance = get_nodes()[closest_node_index].global_position.distance_to(mouse_position)
	for i in range(1, len(get_nodes())):
		var new_distance = get_nodes()[i].global_position.distance_to(mouse_position)
		if new_distance < closest_distance:
			closest_node_index = i
			closest_distance = new_distance

	return closest_node_index
	
func get_closest_edge(mouse_position, max_distance):
	var current_closest_edge = null
	var current_closest_edge_distance = null

	for current_edge_index in range(len(get_nodes())):
		for ref_point in edges_ref_points[current_edge_index]:
			var current_distance = mouse_position.distance_to(ref_point)
			
			if current_distance < max_distance and (current_closest_edge == null or current_distance < current_closest_edge_distance):
				current_closest_edge = current_edge_index
				current_closest_edge_distance = current_distance		
		
	return current_closest_edge

func get_previous_index(current_index):
	if current_index > 0:
		return current_index - 1
	else:
		return len(get_nodes()) - 1

func get_next_index(current_index):
	if current_index < len(get_nodes()) - 1:
		return current_index + 1
	else:
		return 0

func highlight_node(node_index):
	if node_index != current_node:
		if current_node:
			get_nodes()[current_node].set_selected(false)
		
		current_edge = null
		current_node = node_index
		if node_index:
			get_nodes()[current_node].set_selected(true)
		update()
		
func highlight_edge(edge_index):
	if edge_index != current_edge:
		current_node = null
		current_edge = edge_index
		update()


func add_node(node_position, index = null, on_node_selected_target = null, on_node_selected_callback = null):
	if index == null:
		index = len(get_nodes())
	var new_node = node_scene.instance()
	new_node.global_position = node_position
	if on_node_selected_target:
		new_node.get_node('clicable').connect('clicked', on_node_selected_target, on_node_selected_callback)
	
	add_child(new_node)
	move_child(new_node, index)
	
	if index == 0:
		generate_edge_ref_points(len(get_nodes()) - 1)
		generate_edge_ref_points(0, true)
	else:
		generate_edge_ref_points(index - 1)
		generate_edge_ref_points(index, true)
	
	update()


func add_node_next(previous_index, on_node_selected_target = null, on_node_selected_callback = null):
	if len(get_nodes()):
		var new_node_index = get_next_index(previous_index)
		var pos0 = get_child(previous_index).global_position
		var pos1 = get_child(new_node_index).global_position
		var new_node_position = Vector2((pos0.x + pos1.x) / 2, (pos0.y + pos1.y) / 2)
		add_node(new_node_position, previous_index + 1, on_node_selected_target, on_node_selected_callback)


func close():
	closed = true
	update()
	
func open():
	closed = false
	update()
	
func remove_all_nodes():
	for node in get_children():
		node.queue_free()
	current_edge = null
	current_edge = null
	update()


func remove_node(node_index):
	get_children()[node_index].free()
	
	edges_ref_points.remove(node_index)
	if node_index == 0:
		generate_edge_ref_points(len(get_nodes()) - 1)
	else:
		generate_edge_ref_points(node_index - 1)
	
	update()
