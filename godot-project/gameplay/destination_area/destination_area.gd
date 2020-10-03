extends Area2D

var passengers_goal = 1
var passengers_left = 0
var railtrack = null

func _ready():
	railtrack = get_parent()
	global_position = to_global(railtrack.nodes[0])


func update_passengers_label():
	$passengers_label.text = str(passengers_left) + ' / ' + str(passengers_goal)


func _on_destination_area_body_entered(body):
	if body.name == 'player_train':
		passengers_left += body.n_passengers
		body.leave_passengers()
		update_passengers_label()
