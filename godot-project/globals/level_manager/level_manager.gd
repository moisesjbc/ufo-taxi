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


func load_from_file(filepath: String):
	"""
	Loads the level info from the JSON file indexed by the given campaign_index
	and level_index
	"""
	# Source: https://godotengine.org/qa/8291/how-to-parse-a-json-file-i-wrote-myself
	var file = File.new()
	file.open(filepath, file.READ)
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
