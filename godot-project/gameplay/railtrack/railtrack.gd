tool
extends Node2D


var nodes = [
	Vector2(150, 150),
	Vector2(300, 300),
	Vector2(200, 400),
	Vector2(125, 500)
]

func _draw():
	for i in range(len(nodes) - 1):
		draw_line(nodes[i], nodes[i+1], Color.red, 5)
	draw_line(nodes[len(nodes) - 1], nodes[0], Color.red, 5)
