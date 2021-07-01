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

var state_machine = null
var main = null
var level_editor = null
var object = null

func start(object):
	level_editor.get_node('tools_container').visible = true
	self.object = object

func input(event):
	if event is InputEventMouseMotion:
		self.object.global_position = get_global_mouse_position()
		if self.object.has_method('update'):
			self.object.update()
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		state_machine.set_current_state('idle')
