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

extends Area2D

var passengers_goal = 1
var passengers_left = 0
var railtrack = null

signal all_passengers_left

func reset(railtrack, n_pickup_areas):
	self.railtrack = railtrack
	global_position = railtrack.get_nodes()[0].global_position
	passengers_left = 0
	passengers_goal = n_pickup_areas
	update_passengers_label()


func update_passengers_label():
	$passengers_label.set_text(str(passengers_left) + ' / ' + str(passengers_goal))


func _on_destination_area_body_entered(body):
	if body.name == 'player' and body.n_passengers:
		$leaving_cow_audio.play()
		passengers_left += body.n_passengers
		body.leave_passengers()
		update_passengers_label()
		if passengers_left == passengers_goal:
			emit_signal('all_passengers_left')
