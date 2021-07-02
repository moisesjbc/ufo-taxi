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

func set_warning(text):
	$color_rect/label.text = text
	$color_rect.rect_size.x = 15 * len(text)
	visible = true
	$display_timer.start(2)
	set_physics_process(true)
	
func _physics_process(_delta):
	var mouse_global_position = get_global_mouse_position()
	if mouse_global_position.x < 800:
		set_global_position(get_global_mouse_position())
	else:
		set_global_position(get_global_mouse_position() - Vector2($color_rect.rect_size.x, 0))

func _on_display_timer_timeout():
	$color_rect/label.text = ""
	visible = false
	set_physics_process(false)
