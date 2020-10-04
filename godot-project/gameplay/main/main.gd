extends Node2D

signal game_over

var current_level = null
onready var pickup_area_scene = preload("res://gameplay/pickup_area/pickup_area.tscn")
onready var area_51_scene = preload("res://gameplay/area_51/area_51.tscn")


func _ready():
	set_current_level(0)


func _on_railtrack_warning_added(text):
	$warning_label.set_warning(text)


func set_current_level(level_index):
	if current_level:
		for child in current_level.get_children():
			child.visible = false

		if current_level.has_method('end'):
			current_level.end()
	
	current_level = $levels.get_node(str(level_index))
	$railtrack.reset(current_level.railtrack_nodes, current_level.n_remaining_actions)
	$destination_area.reset($railtrack, len(current_level.pickup_area_positions))
	$gui/remaining_actions_label.visible = (current_level.n_remaining_actions != null)
	
	instantiate_areas($pickup_areas, current_level.pickup_area_positions, pickup_area_scene)
	instantiate_areas($area_51_areas, current_level.area_51_positions, area_51_scene)

	for child in current_level.get_children():
		child.visible = true

	if current_level.has_method('start'):
		current_level.start()


func instantiate_areas(parent_node, positions, scene):
	for area in parent_node.get_children():
		area.queue_free()
	
	for position in positions:
		var area = scene.instance()
		parent_node.add_child(area)
		area.global_position = position

func next_level():
	if current_level != null:
		if $levels.get_node(str(int(current_level.name) + 1)):
			set_current_level(int(current_level.name) + 1)
		else:
			get_tree().change_scene("res://menus/ending/ending.tscn")
		
func restart_level():
	if current_level != null:
		set_current_level(int(current_level.name))

func _on_destination_area_all_passengers_left():
	$gui/level_win_menu.display()


func _on_level_win_menu_continue_pressed():
	next_level()


func _on_restart_level_button_button_down():
	restart_level()


func _on_railtrack_n_remaining_actions_updated(n_remaining_actions):
	$gui/remaining_actions_label.text = "Remaining actions: " + str(n_remaining_actions)


func _on_player_train_game_over():
	print("on game over!")
	$gui/game_over.display()


func _on_game_over_restart_level_requested():
	restart_level()
