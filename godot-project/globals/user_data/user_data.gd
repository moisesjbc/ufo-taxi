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

const USER_DATA_FILEPATH = 'user://user-data.json'

var levels_progress = {}


func _ready():
	var file = File.new()
	if file.file_exists(USER_DATA_FILEPATH):
		load_from_file()
	else:
		save_to_file()


func load_from_file():
	var file = File.new()
	file.open(USER_DATA_FILEPATH, file.READ)
	var text = file.get_as_text()
	
	var dict = JSON.parse(text).result
	# TODO: Perform upgrade (if required) when dict['game_version'] !== config.GAME_VERSION
	self.levels_progress = dict['levels_progress']


func save_to_file():
	var file = File.new()
	file.open(USER_DATA_FILEPATH, file.WRITE)
	file.store_string(JSON.print({
		'game_version': config.GAME_VERSION,
		'levels_progress': self.levels_progress
	}, '\t'))


func set_level_passed(level_id: int):
	levels_progress[str(level_id)] = {
		'passed': true
	}
	save_to_file()


func level_passed(level_id: int):
	if str(level_id) in levels_progress:
		return levels_progress[str(level_id)]['passed']
	else:
		return false
