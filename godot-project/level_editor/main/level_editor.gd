extends Node2D

func _ready():
	$railtrack.closed = false

func stop():
	if get_node('main'):
		get_node('main').queue_free()
		$railtrack.visible = true
