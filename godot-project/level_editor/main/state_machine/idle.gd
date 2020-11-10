extends Node2D

var state_machine = null
var level_editor = null

func start():
	if level_editor.get_node('path').nodes.size() > 0:
		$tools_container/clear_vertices_button.visible = true
	else:
		$tools_container/clear_vertices_button.visible = false


func _on_add_vertices_button_pressed():
	state_machine.set_current_state('add_vertices')


func _on_clear_vertices_button_pressed():
	level_editor.get_node('path').remove_all_nodes()


func _on_play_button_pressed():
	var level_dict = {}
	level_dict['railtrack_nodes'] = _vector2_array_to_json_dist(level_editor.get_node('path').nodes)
	level_dict['pickup_area_positions'] = []
	level_dict['area_51_positions'] = []
	level_dict['n_remaining_actions'] = null
	level_dict['texts'] = []
	
	level_editor.get_node('path').visible = false
	var main_scene = load("res://gameplay/main/main.tscn")
	var main = main_scene.instance()
	level_editor.add_child(main)
	level_editor.get_node('main').play_level(level_dict)


func _vector2_array_to_json_dist(vector2_array):
	var res = []
	
	for vector2 in vector2_array:
		res.push_back([vector2.x, vector2.y])
		
	return res
