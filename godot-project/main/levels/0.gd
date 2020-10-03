extends Node2D

var railtrack_nodes = [
	Vector2(300, 100),
	Vector2(800, 100),
	Vector2(800, 500),
	Vector2(300, 500)
]

var pickup_area_positions = [
	Vector2(550, 300)
]

func start():
	for child in get_children():
		child.visible = true
