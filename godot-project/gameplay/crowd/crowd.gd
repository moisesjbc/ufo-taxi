extends Node2D

var festival_crowd = preload("res://gameplay/festival_cow/festival_cow.tscn")
export var n_cows = 600
export var width = 150
export var height = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(n_cows):
		var cow = festival_crowd.instance()
		add_child(cow)
		cow.position = Vector2(randi()%width, randi()%height)
