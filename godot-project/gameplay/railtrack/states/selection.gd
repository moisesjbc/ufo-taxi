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

extends Node

var state_machine = null
var railtrack = null
export var node_selection_distance: int = 25
export var edge_selection_distance: int = 100

func input(event):
	if not railtrack.edit_mode:
		if event is InputEventMouseMotion or event is InputEventScreenTouch or event is InputEventMouseButton:
			var mouse_position = railtrack.get_node('path').to_local(event.position)
			var node_index = railtrack.get_node('path').get_closest_node(mouse_position)
			if node_index != null:
				var node_position = railtrack.get_node('path').get_nodes()[node_index].global_position
				if mouse_position.distance_to(node_position) < node_selection_distance:
					railtrack.get_node('path').highlight_node(node_index)
				else:
					railtrack.get_node('path').highlight_node(null)
					var closest_edge = railtrack.get_node('path').get_closest_edge(mouse_position, edge_selection_distance)
					railtrack.get_node('path').highlight_edge(closest_edge)
			
		if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.pressed:
			railtrack.confirm_current_selection()
