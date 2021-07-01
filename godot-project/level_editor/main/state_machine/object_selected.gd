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
var popup = null

func start(object):
	self.object = object

	popup = PopupMenu.new()
	popup.add_item("Delete")
	popup.set_global_position(self.object.global_position + Vector2(15, 15))
	add_child(popup)
	popup
	popup.connect("id_pressed", self, "_on_item_pressed")
	
func stop():
	if popup:
		popup.queue_free()
	
func _on_item_pressed(id):
	if id == 0:
		state_machine.set_current_state('idle')
		self.object.queue_free()
