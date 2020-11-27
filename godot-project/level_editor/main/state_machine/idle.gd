extends Node2D

var state_machine = null
var main = null
var level_editor = null

func start():
	level_editor.get_node('tools_container').visible = true
	
	if main.get_node('railtrack').get_node('path').get_nodes().size() > 0:
		level_editor.get_node('tools_container').get_node('clear_vertices_button').visible = true
	else:
		level_editor.get_node('tools_container').get_node('clear_vertices_button').visible = false


func reset_objects_container_for_level_editor(objects_container):
	for object in objects_container.get_children():
		object.visible = true


func _on_add_vertices_button_pressed():
	state_machine.set_current_state('add_vertices')


func _on_clear_vertices_button_pressed():
	main.get_path().remove_all_nodes()


func _on_add_pickup_area_button_pressed():
	main.add_pickup_area(self, '_on_object_selected')


func _on_add_area_51_area_pressed():
	main.add_area_51(self, '_on_object_selected')


func _on_object_selected(object):
	# Next if is a workaround for when we are in the "add_vertices" status. It
	# prevents the engine for adding a new node and then inmediatly selecting
	# it, moving us to the "move_object" status.
	# TODO: Refactor the logic so this workaround is not required.
	if state_machine.current_state == self:
		level_editor.get_node('tools_container').get_node('object_properties').set_current_object(object)
		if not level_editor.playing_level:
			state_machine.set_current_state('move_object', object)


func _on_play_button_pressed():
	level_editor.get_node('tools_container').visible = false
	
	_save_data_to_level_manager()
	
	level_manager.playing_from_level_editor = true
	get_tree().change_scene("res://gameplay/main/main.tscn")
	
	"""main.get_path().visible = false
	var main_scene = load("res://gameplay/main/main.tscn")
	var main = main_scene.instance()
	level_editor.add_child(main)
	level_editor.get_node('main').play_level(level_dict)
	level_editor.playing_level = true"""


func _on_save_button_pressed():
	_save_data_to_level_manager()
	level_manager.save() # Save to file


func _save_data_to_level_manager():
	level_manager.railtrack_nodes = []
	for node in main.get_path().get_nodes():
		level_manager.railtrack_nodes.push_back(node.global_position)
	level_manager.pickup_area_positions = []
	for pickup_area in main.get_pickup_areas():
		level_manager.pickup_area_positions.push_back(pickup_area.global_position)
	level_manager.area_51_positions = []
	for area_51 in main.get_areas_51():
		level_manager.area_51_positions.push_back(area_51.global_position)
	level_manager.n_remaining_actions = null
	if level_editor.get_node('tools_container').get_node('actions_limit_container').get_node('actions_limit_input').value > 0:
		level_manager.n_remaining_actions = level_editor.get_node('actions_limit_container').get_node('actions_limit_input').value
	level_manager.texts = []
	for text_label in main.get_texts():
		var text_dict = {
			'position': [text_label.get_global_position().x, text_label.get_global_position().y],
			'size': [text_label.get_size().x, text_label.get_size().y],
			'text': text_label.text
		}
		level_manager.texts.push_back(text_dict)
