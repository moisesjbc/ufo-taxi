extends Node2D

var railtrack = null

var src_position = null
var dst_position = null
var event_mouse_position = null

func start():
	src_position = railtrack.to_global(railtrack.nodes[railtrack.current_edge])
	dst_position = railtrack.to_global(railtrack.nodes[railtrack.get_next_index(railtrack.current_edge)])
	print("Edge selected!")


func input(event):
	if event is InputEventMouseMotion:
		event_mouse_position = event.position
		update()
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			railtrack.add_node(event_mouse_position)
			railtrack.change_state("selection")
			event_mouse_position = null
			update()
		elif event.button_index == BUTTON_RIGHT:
			railtrack.change_state("selection")
			event_mouse_position = null
			update()


func _draw():
	if event_mouse_position != null:
		draw_line(src_position, event_mouse_position, Color.orange, 2)
		draw_line(dst_position, event_mouse_position, Color.orange, 2)
