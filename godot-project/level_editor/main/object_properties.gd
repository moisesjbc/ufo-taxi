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

extends Panel

var current_object = null
var level_editor = null

func set_current_object(new_current_object):
	self.current_object = new_current_object
	if current_object:
		$margin_container/vbox_container/title.text = current_object.name
		$margin_container/vbox_container/add_node_next_button.visible = current_object.is_in_group('nodes')
	visible = current_object != null


func _on_delete_button_pressed():
	self.current_object.queue_free()
	set_current_object(null)


func _on_add_node_next_button_pressed():
	var node_index: int = self.current_object.get_parent().get_node(self.current_object.name).get_index()
	level_editor.add_path_node_next(node_index)
