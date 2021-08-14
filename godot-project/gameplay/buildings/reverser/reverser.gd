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

var type = 'reverser'

func _on_reverser_body_entered(body):
	# Without the cooldown timer, reseting current level while player is on
	# this building would trigger this collision while building is generated
	# but still hasn't be placed on its final position.
	# When playing level from level editor, buildings from editor are hiden
	# and replaced by realtime copies. Disable collisions for the not visible.
	if $cooldown_timer.time_left <= 0.0 and visible and body.name == 'player':
		$hit_sound.play()
		$cooldown_timer.start(1.0)
		body.reverse()
