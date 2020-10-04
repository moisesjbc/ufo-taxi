extends Node2D

var railtrack_nodes = [
	Vector2(300, 150),
	Vector2(900, 150),
	Vector2(900, 600),
	Vector2(300, 600)
]

var pickup_area_positions = [
	Vector2(600, 375)
]

# null = Unlimited actions
var n_remaining_actions = null

var area_51_positions = []
