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

var campaign_name = null
var level_ids = []
var current_level_index = 0
var current_campaign_index = 0

func _load_campaigns_dict():
	var file = File.new()
	file.open(levels_dirpath() + '/campaigns.json', file.READ)
	var text = file.get_as_text()
	return JSON.parse(text).result

func get_number_of_campaigns():
	var dict = _load_campaigns_dict()
	return len(dict['campaigns'])

func set_current_campaign_index(new_current_campaign_index):
	current_campaign_index = new_current_campaign_index

func load_level(level_index: int):
	self.load_current_campaign_info()
	self._load_level(level_index)


func _load_level(level_index: int):
	self.current_level_index = level_index
	level_manager.load_campaign_level_from_file(campaign_manager.level_ids[level_index])


func load_current_campaign_info():
	var dict = _load_campaigns_dict()
	self.campaign_name = dict['campaigns'][current_campaign_index]['name']
	self.level_ids = dict['campaigns'][current_campaign_index]['levels']


func load_next_level():
	current_level_index += 1
	if current_level_index < len(level_ids):
		self._load_level(current_level_index)
	else:
		get_tree().change_scene("res://menus/ending/ending.tscn")


func levels_dirpath():
	return 'res://levels/campaign'


func add_level(level_id: int):
	var file = File.new()
	file.open(levels_dirpath() + '/campaigns.json', file.READ)
	var text = file.get_as_text()
	
	var dict = JSON.parse(text).result
	if not level_id in level_ids:
		dict['campaigns'][current_campaign_index]['levels'].append(level_id)
		level_ids.append(level_id)
		file.close()
		file.open(levels_dirpath() + '/campaigns.json', file.WRITE)
		file.store_string(JSON.print(dict, '\t'))


func get_next_level_free_id():
	var dict = _load_campaigns_dict()
	var last_level_id = 0
	for campaign_dict in dict['campaigns']:
		for level_id in campaign_dict['levels']:
			last_level_id = max(last_level_id, level_id)
	return last_level_id + 1
