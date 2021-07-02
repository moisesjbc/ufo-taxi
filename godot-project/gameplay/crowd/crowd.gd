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

var festival_crowd = preload("res://gameplay/festival_cow/festival_cow.tscn")
export var n_cows = 600
export var width = 150
export var height = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in range(n_cows):
		var cow = festival_crowd.instance()
		add_child(cow)
		cow.position = Vector2(randi()%width, randi()%height)
