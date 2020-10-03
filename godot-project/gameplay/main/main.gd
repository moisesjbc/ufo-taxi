extends Node2D

signal game_over

var current_level = null
onready var pickup_area_scene = preload("res://gameplay/pickup_area/pickup_area.tscn")


func _ready():
	set_current_level(0)


func _on_railtrack_warning_added(text):
	$warning_label.set_warning(text)


func set_current_level(level_index):
	current_level = $levels.get_node(str(level_index))
	$railtrack.reset(current_level.railtrack_nodes)
	$destination_area.reset($railtrack, 1)
	
	for pickup_area in $pickup_areas.get_children():
		pickup_area.queue_free()
	
	for pickup_area_position in current_level.pickup_area_positions:
		var pickup_area = pickup_area_scene.instance()
		$pickup_areas.add_child(pickup_area)
		pickup_area.global_position = pickup_area_position

	if current_level.has_method('start'):
		current_level.start()


func next_level():
	if current_level != null:
		#set_current_level(int(current_level.name) + 1)
		set_current_level(int(current_level.name))


func _on_destination_area_all_passengers_left():
	$menus/level_win_menu.display()


func _on_level_win_menu_continue_pressed():
	next_level()
