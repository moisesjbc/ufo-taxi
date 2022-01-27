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

extends Node2D

var level_editor = null
var main = null
var state_machine = null

func start():
	level_editor.get_node('tools_container').visible = false
	main.get_path().open()

func input(event):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed and not Rect2($add_vertices_exit_button.rect_position, $add_vertices_exit_button.rect_size).has_point(event.position):
		var mouse_position = main.get_path().to_local(event.position)
		level_editor.add_path_node(mouse_position)


func _on_add_vertices_exit_button_pressed():
	main.get_path().close()
	state_machine.set_current_state('idle')
