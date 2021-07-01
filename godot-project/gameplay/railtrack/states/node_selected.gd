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

extends Node

var state_machine = null
var railtrack = null

func start():
	$remove_button.visible = true
	var vertex_pos = railtrack.to_global(railtrack.get_node('path').get_nodes()[railtrack.get_node('path').current_node].position)
	if vertex_pos.y < 600:
		$remove_button.set_global_position(vertex_pos + Vector2(0, 15))
	else:
		$remove_button.set_global_position(vertex_pos + Vector2(0, -80))


func _on_remove_button_confirmed():
	$remove_button.visible = false
	railtrack.remove_current_node()
	state_machine.change_state("selection")


func _on_remove_button_cancelled():
	$remove_button.visible = false
	railtrack.get_node('path').highlight_node(null)
	state_machine.change_state("selection")


func end():
	$remove_button.visible = false
