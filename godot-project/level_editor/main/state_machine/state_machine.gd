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

var current_state = null


func _ready():
	set_current_state('idle')


func set_current_state(new_state_name, arg=null):
	var new_state = get_node(new_state_name)

	if current_state:
		for child in current_state.get_children():
			child.visible = false
		if current_state.has_method('stop'):
			current_state.stop()
	
	current_state = new_state
	
	current_state.state_machine = self
	current_state.level_editor = self.get_parent()
	current_state.main = self.get_parent().get_node('main')
	
	if current_state:
		if current_state.has_method('start'):
			if arg:
				current_state.start(arg)
			else:
				current_state.start()
		for child in current_state.get_children():
			child.visible = true


func _physics_process(delta):
	if current_state and current_state.has_method('physics_process'):
		current_state.physics_process(delta)

func _input(event):
	if current_state and current_state.has_method('input'):
		current_state.input(event)
