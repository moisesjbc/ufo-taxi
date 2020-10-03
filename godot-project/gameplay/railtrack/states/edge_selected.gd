extends Node2D

var railtrack = null

var src_position = null
var dst_position = null
var middle_point = null
var event_mouse_position = null
var max_distance = 200
var distance_to_middle_point = 0


func start():
	src_position = railtrack.to_global(railtrack.nodes[railtrack.current_edge])
	dst_position = railtrack.to_global(railtrack.nodes[railtrack.get_next_index(railtrack.current_edge)])
	middle_point = Vector2((src_position.x + dst_position.x) / 2, (src_position.y + dst_position.y) / 2)


func input(event):
	if event is InputEventMouseMotion:
		event_mouse_position = event.position
		distance_to_middle_point = middle_point.distance_to(event_mouse_position)
		update()
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if distance_to_middle_point <= max_distance:
				railtrack.add_node(event_mouse_position)
				railtrack.change_state("selection")
				event_mouse_position = null
				update()
			else:
				railtrack.warning("Too far!")
		elif event.button_index == BUTTON_RIGHT:
			railtrack.change_state("selection")
			event_mouse_position = null
			update()


func _draw():
	if event_mouse_position != null:
		var color = get_lines_color()
		draw_line(src_position, event_mouse_position, color, 2)
		draw_line(dst_position, event_mouse_position, color, 2)


func get_lines_color():
	if distance_to_middle_point <= max_distance:
		return Color.orange
	else:
		return Color.red
