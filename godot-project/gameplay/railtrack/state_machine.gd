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

var current_state = null
var player = null
var railtrack = null

func change_state(new_state_name):
	if current_state and current_state.has_method('end'):
		current_state.end()
	current_state = get_node(new_state_name)
	current_state.state_machine = self
	current_state.railtrack = railtrack
	if current_state and current_state.has_method('start'):
		current_state.start()

func _physics_process(delta):
	if current_state and current_state.has_method('process'):
		current_state.process(delta)

func _input(event):
	if current_state and current_state.has_method('input'):
		current_state.input(event)
		
func _draw():
	if current_state or not player:
		if current_state and current_state.has_method('draw'):
			current_state.draw()
		else:
			$path._draw()
