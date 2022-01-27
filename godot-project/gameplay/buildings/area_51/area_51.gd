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

extends Area2D

var type = 'area_51'

func _on_area_51_body_entered(body):
	# On first iteration of level, area 51 is not on its final position and
	# could be colliding with the player. We add a small "cooldown" timer
	# for avoiding killing the player at the begining ;-)
	if $cooldown_timer.time_left <= 0 and body.name == 'player':
		body.die()
		$ufo_explosion_sound.play()
