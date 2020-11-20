extends Node2D

var state_machine = null
var level_editor = null
var pickup_area_scene = preload('res://gameplay//pickup_area/pickup_area.tscn')
var area_51_scene = preload('res://gameplay//area_51/area_51.tscn')

func start():
	$tools_container.visible = true
	
	if level_editor.get_node('path').nodes.size() > 0:
		$tools_container/clear_vertices_button.visible = true
	else:
		$tools_container/clear_vertices_button.visible = false
		
	level_editor.get_node('path').visible = true
	
	for pickup_area in level_editor.get_node('pickup_areas_container').get_children():
		pickup_area.visible = true
		
	reset_objects_container_for_level_editor(level_editor.get_node('pickup_areas_container'))
	reset_objects_container_for_level_editor(level_editor.get_node('area_51_container'))


func reset_objects_container_for_level_editor(objects_container):
	for object in objects_container.get_children():
		object.visible = true


func _on_add_vertices_button_pressed():
	state_machine.set_current_state('add_vertices')


func _on_clear_vertices_button_pressed():
	level_editor.get_node('path').remove_all_nodes()



func _on_add_pickup_area_button_pressed():
	add_object(pickup_area_scene, level_editor.get_node('pickup_areas_container'))


func _on_add_area_51_area_pressed():
	add_object(area_51_scene, level_editor.get_node('area_51_container'))


func add_object(object_scene, objects_container):
	var object = object_scene.instance()
	objects_container.add_child(object)
	object.global_position = Vector2(OS.window_size.x / 2.0, OS.window_size.y / 2.0)
	
	# Set every object on a different "layer" so we can select always one maximum.
	object.z_index = -objects_container.get_children().size() - 1

	object.get_node('clicable').connect("clicked", self, "_on_object_selected")
	object.get_node('clicable').connect("double_clicked", self, "_on_object_double_selected")

func _on_object_selected(object):
	if not level_editor.playing_level:
		state_machine.set_current_state('move_object', object)

func _on_object_double_selected(object):
	if not level_editor.playing_level:
		state_machine.set_current_state('object_selected', object)

func _on_play_button_pressed():
	$tools_container.visible = false
	
	var level_dict = {}
	
	level_manager.railtrack_nodes = level_editor.get_node('path').nodes
	level_manager.pickup_area_positions = []
	for pickup_area in level_editor.get_node('pickup_areas_container').get_children():
		level_manager.pickup_area_positions.push_back(pickup_area.global_position)
		pickup_area.visible = false
	level_manager.area_51_positions = []
	for area_51 in level_editor.get_node('area_51_container').get_children():
		level_manager.area_51_positions.push_back(area_51.global_position)
		area_51.visible = false
	level_manager.n_remaining_actions = null
	if $tools_container/actions_limit_container/actions_limit_input.value > 0:
		level_manager.n_remaining_actions = $tools_container/actions_limit_container/actions_limit_input.value
	level_manager.texts = []
	
	level_manager.save()
	level_manager.playing_from_level_editor = true
	get_tree().change_scene("res://gameplay/main/main.tscn")
	
	"""level_editor.get_node('path').visible = false
	var main_scene = load("res://gameplay/main/main.tscn")
	var main = main_scene.instance()
	level_editor.add_child(main)
	level_editor.get_node('main').play_level(level_dict)
	level_editor.playing_level = true"""
