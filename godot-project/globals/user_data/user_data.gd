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

extends Node

const USER_DATA_FILEPATH = 'user://user-data.json'

var levels_progress = {}
var campaigns_progress = {}


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
	self.levels_progress = dict['levels_progress'] if 'levels_progress' in dict else {}
	self.campaigns_progress = dict['campaigns_progress'] if 'campaigns_progress' in dict else {}


func save_to_file():
	var file = File.new()
	file.open(USER_DATA_FILEPATH, file.WRITE)
	file.store_string(JSON.print({
		'game_version': config.GAME_VERSION,
		'levels_progress': self.levels_progress,
		'campaigns_progress': self.campaigns_progress
	}, '\t'))


func set_level_passed(level_id: int):
	_set_section_passed(levels_progress, level_id)
	
func set_campaign_passed(campaign_index: int):
	_set_section_passed(campaigns_progress, campaign_index)
	
func _set_section_passed(section_dict, section_id: int):
	section_dict[str(section_id)] = {
		'passed': true
	}
	save_to_file()


func level_passed(level_id: int):
	return _section_passed(levels_progress, level_id)

func campaign_passed(campaign_index: int):
	return _section_passed(campaigns_progress, campaign_index)

func _section_passed(section_dict: Dictionary, section_id: int):
	if str(section_id) in section_dict:
		return section_dict[str(section_id)]['passed']
	else:
		return false
	
