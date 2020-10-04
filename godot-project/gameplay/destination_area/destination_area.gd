extends Area2D

var passengers_goal = 1
var passengers_left = 0
var railtrack = null

signal all_passengers_left

func reset(railtrack, n_pickup_areas):
	self.railtrack = railtrack
	global_position = railtrack.nodes[0]
	passengers_left = 0
	passengers_goal = n_pickup_areas
	update_passengers_label()


func update_passengers_label():
	$passengers_label.set_text(str(passengers_left) + ' / ' + str(passengers_goal))


func _on_destination_area_body_entered(body):
	if body.name == 'player' and body.n_passengers:
		$leaving_cow_audio.play()
		passengers_left += body.n_passengers
		body.leave_passengers()
		update_passengers_label()
		if passengers_left == passengers_goal:
			emit_signal('all_passengers_left')
