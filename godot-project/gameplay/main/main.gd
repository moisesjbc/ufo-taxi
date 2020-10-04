extends Node2D

signal game_over

var current_level = null
onready var pickup_area_scene = preload("res://gameplay/pickup_area/pickup_area.tscn")


func _ready():
	set_current_level(3)


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
	$destination_area.reset($railtrack, 1)
	$gui/remaining_actions_label.visible = (current_level.n_remaining_actions != null)
	
	for pickup_area in $pickup_areas.get_children():
		pickup_area.queue_free()
	
	for pickup_area_position in current_level.pickup_area_positions:
		var pickup_area = pickup_area_scene.instance()
		$pickup_areas.add_child(pickup_area)
		pickup_area.global_position = pickup_area_position

	for child in current_level.get_children():
		child.visible = true

	if current_level.has_method('start'):
		current_level.start()


func next_level():
	if current_level != null and $levels.get_node(str(int(current_level.name) + 1)):
		set_current_level(int(current_level.name) + 1)
		
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
