extends Node

"""
Utility script for loading the level data from a JSON file.
"""

var railtrack_nodes = []

# null = Unlimited actions
var n_remaining_actions = null

var building_defs = []

var campaign_index = null;
var level_index = null;

var texts = [];

var level_id = null

var playing_from_level_editor: bool = false


func load_campaign_level_from_file(level_id: int):
	"""
	Loads the level info from the JSON file indexed by the given ID
	"""
	playing_from_level_editor = false

	# Source: https://godotengine.org/qa/8291/how-to-parse-a-json-file-i-wrote-myself
	var file = File.new()
	file.open(campaign_level_filepath(level_id), file.READ)
	self.level_id = level_id
	var text = file.get_as_text()
	
	var dict = JSON.parse(text).result
	
	self.campaign_index = campaign_index
	self.level_index = level_index

	load_from_dict(dict)
	file.close()


func load_from_dict(dict):
	railtrack_nodes = self._read_vector2_list_from_json(dict['railtrack_nodes'])
	building_defs = self._read_building_defs_list_from_json(dict['buildings'] if 'buildings' in dict else [])
	n_remaining_actions = dict['n_remaining_actions']
	
	for child in get_children():
		child.queue_free()
		
	texts = dict['texts']


func _read_vector2_list_from_json(json_list):
	"""
	Reads a list of tuples from the given JSON list and returns an array
	of Vector2 from it.
	"""
	var res = []
	
	for json_railtrack_node in json_list:
		res.push_back(Vector2(json_railtrack_node[0], json_railtrack_node[1]))
	
	return res
	
func _read_building_defs_list_from_json(building_defs):
	var res = []

	for building_def in building_defs:
		res.push_back({
			'type': building_def.type,
			'position': Vector2(building_def.position[0], building_def.position[1])
		})
	
	return res


func reset(level_id):
	railtrack_nodes = []
	n_remaining_actions = null
	texts = [];
	self.level_id = level_id


func create_campaign_level(level_id: int):
	reset(level_id)
	save()


func campaign_level_filepath(level_id: int):
	return campaign_manager.levels_dirpath() + '/' + String(level_id) + '.json'


func save():
	var file = File.new()
	file.open(campaign_level_filepath(level_id), file.WRITE)
	file.store_string(JSON.print({
		'version': config.GAME_VERSION,
		'railtrack_nodes': _vector2_array_to_json_dist(railtrack_nodes),
		'buildings': _building_defs_to_json(building_defs),
		'n_remaining_actions': n_remaining_actions,
		'texts': texts
	}, '\t'))


func _vector2_array_to_json_dist(vector2_array):
	var res = []
	
	for vector2 in vector2_array:
		res.push_back([vector2.x, vector2.y])
		
	return res

func _building_defs_to_json(building_defs):
	var res = []

	for building_def in building_defs:
		res.push_back({
			'type': building_def['type'],
			'position': [building_def['position'].x, building_def['position'].y]
		})
		
	return res


func passed():
	if not playing_from_level_editor:
		user_data.set_level_passed(level_id)
