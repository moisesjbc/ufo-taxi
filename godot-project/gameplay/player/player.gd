"""
Copyright 2020-2022 Moisés J. Bonilla Caraballo (moisesjbc)

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

extends KinematicBody2D

var path = null
var current_node_index: int = 0
var next_node_index: int = 1
export var speed: int = 200
var n_passengers: int = 0
var going_forward: bool = true

signal game_over

func _ready():
	set_physics_process(false)

func reset(new_path):
	current_node_index = 0
	next_node_index = 1
	n_passengers = 0
	going_forward = true
	set_physics_process(true)
	self.path = new_path
	position = new_path.get_nodes()[0].global_position
	update_passengers_label()
	
func reverse():
	going_forward = not going_forward
	self.path.reverse_ufo_guides()
	
	var aux = current_node_index
	current_node_index = next_node_index
	next_node_index = aux
	
func current_edge_index():
	if going_forward:
		return current_node_index
	else:
		return next_node_index

func change_next_node():
	# Update current node index
	current_node_index = increase_node_index(current_node_index)
	
	# Update next node index
	next_node_index = increase_node_index(next_node_index)
		
func increase_node_index(node_index):
	if going_forward:
		node_index = node_index + 1
		if node_index >= len(path.get_nodes()):
			node_index = 0
	else:
		node_index = node_index - 1
		if node_index < 0:
			node_index = len(path.get_nodes()) - 1

	return node_index
	
func _physics_process(delta):
	# Compute velocity
	var velocity = path.get_nodes()[next_node_index].global_position - path.get_nodes()[current_node_index].global_position
	$sprite_body.rotate(0.01)
	
	var fast_foward_bonus = get_parent().get_parent().fast_foward_bonus()

	if position.distance_to(path.get_nodes()[next_node_index].global_position) > speed * delta * fast_foward_bonus:
		# Train is still far to next node. Advance.
		# warning-ignore:return_value_discarded
		move_and_collide(velocity.normalized() * speed * delta * fast_foward_bonus)
	else:
		# Trail is very close to the next node. Advance to its position and
		# change to next node.
		# warning-ignore:return_value_discarded
		move_and_collide(velocity.normalized() * position.distance_to(path.get_nodes()[next_node_index].global_position))
		change_next_node()


func _on_railtrack_node_removed(node_index):
	if node_index <= current_node_index:
		current_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(path.nodes) - 1
		
	if 	node_index <= next_node_index:
		next_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(path.nodes) - 1


func _on_railtrack_node_added(node_index):
	if node_index <= current_node_index:
		current_node_index = path.get_next_index(current_node_index)
	if node_index <= next_node_index:
		next_node_index = path.get_next_index(next_node_index)

func pick_passenger():
	n_passengers += 1
	update_passengers_label()
	
func leave_passengers():
	n_passengers = 0
	update_passengers_label()
	
func update_passengers_label():
	$passengers_label.set_text(str(n_passengers))

func die():
	emit_signal("game_over")
