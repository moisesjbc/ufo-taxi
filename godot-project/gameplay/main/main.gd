extends Node2D

signal game_over

onready var pickup_area_scene = preload("res://gameplay/pickup_area/pickup_area.tscn")
onready var area_51_scene = preload("res://gameplay/area_51/area_51.tscn")


func _ready():
	if not get_parent().name == 'level_editor':
		set_current_level(0)
		$gui/restart_level_button.visible = true
		$gui/return_to_level_editor_button.visible = false
	else:
		$gui/restart_level_button.visible = false
		$gui/return_to_level_editor_button.visible = true


func _on_railtrack_warning_added(text):
	$warning_label.set_warning(text)


func set_current_level(level_index):
	reset_current_level()
	
func reset_current_level():
	$railtrack.reset(level_manager.railtrack_nodes, level_manager.n_remaining_actions)
	$destination_area.reset($railtrack.get_node('path'), len(level_manager.pickup_area_positions))
	$gui/remaining_actions_label.visible = (level_manager.n_remaining_actions != null)

	instantiate_areas($pickup_areas, level_manager.pickup_area_positions, pickup_area_scene)
	instantiate_areas($area_51_areas, level_manager.area_51_positions, area_51_scene)
	instantiate_texts($texts, level_manager.texts)


# TODO: REMOVE
func play_level(level_dict):
	level_manager.load_from_dict(level_dict)
	reset_current_level()


func instantiate_areas(parent_node, positions, scene):
	for area in parent_node.get_children():
		area.queue_free()
	
	for position in positions:
		var area = scene.instance()
		parent_node.add_child(area)
		area.global_position = position


func instantiate_texts(parent_node, texts):
	for text in parent_node.get_children():
		text.queue_free()
	
	for text in texts:
		var label = Label.new()
		label.set_global_position(Vector2(text['position'][0], text['position'][1]))
		label.set_size(Vector2(text['size'][0], text['size'][1]))
		label.text = text['text']
		parent_node.add_child(label)

func next_level():
	campaign_manager.load_next_level()
	reset_current_level()

func restart_level():
	if campaign_manager != null:
		set_current_level(campaign_manager.current_level_index)

func _on_destination_area_all_passengers_left():
	$gui/level_win_menu.display()


func _on_level_win_menu_continue_pressed():
	next_level()


func _on_restart_level_button_button_down():
	restart_level()


func _on_railtrack_n_remaining_actions_updated(n_remaining_actions):
	$gui/remaining_actions_label.text = "Remaining actions: " + str(n_remaining_actions)


func _on_player_train_game_over():
	$gui/game_over.display()


func _on_game_over_restart_level_requested():
	restart_level()


func _on_return_to_level_editor_button_pressed():
	get_parent().stop()
