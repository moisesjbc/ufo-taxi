extends Node

"""
Utility script for loading the level data from a JSON file.
"""

var railtrack_nodes = []

var pickup_area_positions = []

# null = Unlimited actions
var n_remaining_actions = null

var area_51_positions = []

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
	pickup_area_positions = self._read_vector2_list_from_json(dict['pickup_area_positions'])
	area_51_positions = self._read_vector2_list_from_json(dict['area_51_positions'])
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


func reset(level_id):
	railtrack_nodes = []
	pickup_area_positions = []
	n_remaining_actions = null
	area_51_positions = []
	texts = [];
	self.level_id = level_id


func create_campaign_level(level_id: int, campaign_index: int = 0):
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
		'pickup_area_positions': _vector2_array_to_json_dist(pickup_area_positions),
		'area_51_positions': _vector2_array_to_json_dist(area_51_positions),
		'n_remaining_actions': n_remaining_actions,
		'texts': texts
	}, '\t'))


func _vector2_array_to_json_dist(vector2_array):
	var res = []
	
	for vector2 in vector2_array:
		res.push_back([vector2.x, vector2.y])
		
	return res


func passed():
	if not playing_from_level_editor:
		user_data.set_level_passed(level_id)
