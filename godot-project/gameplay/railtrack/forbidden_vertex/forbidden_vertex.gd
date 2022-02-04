extends Node2D

var forbidden_signal_texture = preload("res://gameplay/railtrack/forbidden_vertex/forbidden_signal.png")

func clear():
	for forbidden_signal in get_children():
		forbidden_signal.queue_free()


func display(new_vertex, src_vertex, dst_vertex):
	clear()

	_generate_forbidden_signals(src_vertex, new_vertex)
	_generate_forbidden_signals(new_vertex, dst_vertex)


func _generate_forbidden_signals(src_vertex, dst_vertex):
	var distance = src_vertex.distance_to(dst_vertex)
	var direction = (dst_vertex - src_vertex).normalized()
	var distance_between_signals = 60
	var offset = 10

	var n_divisions = (distance - offset * 2) / distance_between_signals
	var origin_vertex = src_vertex + direction * offset
	for i in range(0, n_divisions + 1):
		var forbidden_signal = Sprite.new()
		forbidden_signal.scale = Vector2(0.5, 0.5)
		forbidden_signal.texture = forbidden_signal_texture
		forbidden_signal.position = origin_vertex + direction * i * distance_between_signals
		add_child(forbidden_signal)


func hide():
	clear()
