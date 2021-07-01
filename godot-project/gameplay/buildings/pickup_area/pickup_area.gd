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

onready var has_passengers: bool = true
var type = 'farm'

func _ready():
	update_label()

func _on_pickup_area_body_entered(body):
	# Without the cooldown timer, reseting current level while player is on a
	# pickup area would trigger this collision while pickup area is generated
	# but still hasn't be placed on its final position.
	# When playing level from level editor, pickup areas from editor are hiden
	# and replaced by realtime copies. Disable collisions for the not visible.
	if $cooldown_timer.time_left <= 0 and visible and body.name == 'player' and has_passengers:
		has_passengers = false
		update_label()
		body.pick_passenger()
		$pickup_sound.play()

func update_label():
	if has_passengers:
		$cow_label.set_text("1")
	else:
		$cow_label.set_text("0")
