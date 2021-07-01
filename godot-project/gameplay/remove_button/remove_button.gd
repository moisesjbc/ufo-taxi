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

extends TextureButton

signal confirmed
signal cancelled

func _input(event):
	# Emit cancelled signal if user clicks outside of the confirm button.
	if visible and (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed \
		and not Rect2(rect_global_position, rect_size).has_point(event.position):
			emit_signal('cancelled')


func _on_remove_button_pressed():
	emit_signal('confirmed')
