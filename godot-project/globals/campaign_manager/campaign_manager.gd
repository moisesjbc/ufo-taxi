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
	self.load_campaign_info(current_campaign_index)
	self._load_level(level_index)


func _load_level(level_index: int):
	self.current_level_index = level_index
	level_manager.load_campaign_level_from_file(campaign_manager.level_ids[level_index])


func load_campaign_info(campaign_index: int):
	var dict = _load_campaigns_dict()
	self.campaign_name = dict['campaigns'][campaign_index]['name']
	self.level_ids = dict['campaigns'][campaign_index]['levels']


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
