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
