"""
Copyright 2020-2022 Moisés J. Bonilla Caraballo (moisesjbc)

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

extends Node2D

export (bool) var edit_mode = false
var fast_foward_activated: bool = false

onready var pickup_area_scene = preload("res://gameplay/buildings/pickup_area/pickup_area.tscn")
onready var area_51_scene = preload("res://gameplay/buildings/area_51/area_51.tscn")
onready var reverser_scene = preload("res://gameplay/buildings/reverser/reverser.tscn")


func _ready():
	reset_current_level()
	$gui/restart_level_button.visible = not level_manager.playing_from_level_editor and not edit_mode
	$gui/return_to_level_editor_button.visible = level_manager.playing_from_level_editor and not edit_mode
	$gui/fast_foward_button.visible = not edit_mode


func _on_railtrack_warning_added(text):
	$warning_label.set_warning(text)
	

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause") and not $gui/level_win_menu.visible:
		$gui/pause_menu.start()


func reset_current_level(on_object_selected_target = null, on_object_selected_callback = null):
	$gui/pause_menu.visible = not edit_mode
	$railtrack.reset(level_manager.railtrack_nodes, level_manager.n_remaining_actions, edit_mode, on_object_selected_target, on_object_selected_callback)
	if not edit_mode:
		var n_farms = 0
		for building in level_manager.building_defs:
			if building.type == 'farm':
				n_farms += 1
		$destination_area.reset($railtrack.get_node('path'), n_farms)
	else:
		$destination_area.visible = false
	$gui/remaining_actions.visible = not edit_mode and (level_manager.n_remaining_actions != null)

	instantiate_buildings(level_manager.building_defs, on_object_selected_target, on_object_selected_callback)
	
	instantiate_texts($texts, level_manager.texts)
	
	fast_foward_activated = false
	$gui/fast_foward_button.pressed = false


# TODO: REMOVE
func play_level(level_dict):
	level_manager.load_from_dict(level_dict)
	reset_current_level()


func instantiate_areas(parent_node, positions, scene, on_object_selected_target = null, on_object_selected_callback = null):
	for area in parent_node.get_children():
		area.queue_free()
	
	for position in positions:
		var area = scene.instance()
		parent_node.add_child(area)
		area.global_position = position
		
		connect_object_selected_signal(area, on_object_selected_target, on_object_selected_callback)
		
func instantiate_buildings(building_defs, on_object_selected_target = null, on_object_selected_callback = null):
	for building in $buildings.get_children():
		building.free()

	for building_def in building_defs:
		var building_scene = get_building_scene(building_def.type)
		var building = building_scene.instance()
		$buildings.add_child(building)
		building.global_position = building_def.position
		
		connect_object_selected_signal(building, on_object_selected_target, on_object_selected_callback)

func connect_object_selected_signal(object, on_object_selected_target = null, on_object_selected_callback = null):
	if on_object_selected_target:
		object.get_node('clicable').connect("clicked", on_object_selected_target, on_object_selected_callback)


func instantiate_texts(parent_node, texts):
	for text in parent_node.get_children():
		text.queue_free()
	
	for text in texts:
		var label = Label.new()
		label.set_global_position(Vector2(text['position'][0], text['position'][1]))
		label.set_size(Vector2(text['size'][0], text['size'][1]))
		label.text = text['text']
		if 'color' in text:
			label.add_color_override('font_color', Color(text['color']))
		if 'horizontal_align' in text:
			if text['horizontal_align'] == 'center':
				label.align = HALIGN_CENTER
			elif text['horizontal_align'] == 'right':
				label.align = HALIGN_RIGHT
			else:
				label.align = HALIGN_LEFT
		parent_node.add_child(label)

func next_level():
	campaign_manager.load_next_level()
	reset_current_level()

func restart_level():
	if campaign_manager != null:
		reset_current_level()

func _on_destination_area_all_passengers_left():
	level_manager.passed()
	$gui/level_win_menu.display()
	$gui/pause_menu.visible = false


func _on_level_win_menu_continue_pressed():
	next_level()


func _on_restart_level_button_button_down():
	restart_level()


func _on_railtrack_n_remaining_actions_updated(n_remaining_actions):
	$gui/remaining_actions/container/label.text = "Remaining actions: " + str(n_remaining_actions)


func _on_player_train_game_over():
	$gui/game_over.display()


func _on_game_over_restart_level_requested():
	restart_level()


func _on_return_to_level_editor_button_pressed():
	scene_manager.change_scene("res://level_editor/main/level_editor.tscn")


func get_path():
	return $railtrack/path


func add_building(building_type, signal_target, on_object_selected):
	var building_scene = get_building_scene(building_type)
	add_object(building_scene, $buildings, signal_target, on_object_selected)

func get_building_scene(building_type):
	if building_type == 'reverser':
		return reverser_scene
	elif building_type == 'farm':
		return pickup_area_scene
	elif building_type == 'area_51':
		return area_51_scene


func add_object(object_scene, objects_container, signal_target, on_object_selected):
	var object = object_scene.instance()
	objects_container.add_child(object)
	object.global_position = Vector2(OS.window_size.x / 2.0, OS.window_size.y / 2.0)
	
	# Set every object on a different "layer" so we can select always one maximum.
	object.z_index = -objects_container.get_children().size() - 1

	connect_object_selected_signal(object, signal_target, on_object_selected)


func get_buildings():
	return $buildings.get_children()
	
func get_texts():
	return $texts.get_children()



func _on_fast_foward_button_toggled(button_pressed):
	fast_foward_activated = button_pressed


func fast_foward_bonus():
	if fast_foward_activated:
		return 2.5
	else:
		return 1
