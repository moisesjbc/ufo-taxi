extends Node2D

var railtrack_nodes = [
	# OK
	Vector2(500, 150),
	Vector2(800, 200),
	Vector2(900, 400),
	Vector2(800, 600),
	Vector2(500, 700),
	Vector2(200, 600),
	Vector2(100, 400),
	Vector2(200, 200)
]

var pickup_area_positions = [
	Vector2(500, 470)
]

# null = Unlimited actions
var n_remaining_actions = 2

var area_51_positions = []
