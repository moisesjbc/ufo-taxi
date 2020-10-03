extends Node

var railtrack = null

func start():
	print("Edge selected!")

func input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		railtrack.change_state("selection")
