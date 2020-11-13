extends Area2D

signal clicked
signal double_clicked

func _input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed:
		if event.doubleclick:
			emit_signal('double_clicked', get_parent())
		else:
			emit_signal('clicked', get_parent())
