extends Node

var campaign_name = null
var level_ids = []
var current_level_index = 0

func load_level(campaign_index: int, level_index: int):
	self.load_campaign_info(campaign_index)
	self._load_level(level_index)


func _load_level(level_index: int):
	self.current_level_index = level_index
	level_manager.load_from_file(self._level_filepath(level_index))


func load_campaign_info(campaign_index: int):
	var file = File.new()
	file.open('res://levels/campaign/campaigns.json', file.READ)
	var text = file.get_as_text()
	
	var dict = JSON.parse(text).result
	
	print(dict['campaigns'][campaign_index])
	self.campaign_name = dict['campaigns'][campaign_index]['name']
	self.level_ids = dict['campaigns'][campaign_index]['levels']


func _level_filepath(level_index):
	return 'res://levels/campaign/' + str(self.level_ids[level_index]) + '.json'


func load_next_level():
	current_level_index += 1
	if current_level_index < len(level_ids):
		self._load_level(current_level_index)
	else:
		get_tree().change_scene("res://menus/ending/ending.tscn")
