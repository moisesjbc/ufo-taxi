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

var playing_level = false


func _ready():
	$main.reset_current_level($state_machine/idle, '_on_object_selected')
	$main/railtrack/path.closed = false
	$tools_container/object_properties.level_editor = self
	if level_manager.n_remaining_actions != null:
		$tools_container/actions_limit_container/actions_limit_input.value = level_manager.n_remaining_actions
	get_node('tools_container').get_node('object_properties').set_current_object(null)


func stop():
	if get_node('main'):
		get_node('main').queue_free()
		$state_machine.set_current_state('idle')
		playing_level = false


func add_path_node_next(node_index):
	var main = get_node('main')
	main.get_path().add_node_next(node_index, $state_machine/idle, '_on_object_selected')
	
func add_path_node(node_index):
	var main = get_node('main')
	main.get_path().add_node(node_index, null, $state_machine/idle, '_on_object_selected')


func _on_return_to_main_menu_button_pressed():
	scene_manager.change_scene("res://menus/level_selector/level_selector.tscn")
