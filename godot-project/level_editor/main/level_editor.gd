extends Node2D

var playing_level = false


func _ready():
	$main.reset_current_level()
	$main/railtrack/path.closed = false
	$tools_container/object_properties.level_editor = self
	get_node('tools_container').get_node('object_properties').set_current_object(null)


func stop():
	if get_node('main'):
		get_node('main').queue_free()
		$state_machine.set_current_state('idle')
		playing_level = false


func add_path_node_next(node_index):
	var main = get_node('main')
	main.get_path().add_node_next(node_index, $state_machine/idle, '_on_object_selected')
	
func add_path_node(node_index):
	var main = get_node('main')
	main.get_path().add_node(node_index, null, $state_machine/idle, '_on_object_selected')
