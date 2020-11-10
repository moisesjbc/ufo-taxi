extends Node2D

var playing_level = false

func _ready():
	$path.closed = false

func stop():
	if get_node('main'):
		get_node('main').queue_free()
		$state_machine.set_current_state('idle')
		playing_level = false
