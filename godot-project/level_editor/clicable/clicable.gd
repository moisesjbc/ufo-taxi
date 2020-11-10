extends Area2D

signal clicked

func _input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		emit_signal('clicked', get_parent())
