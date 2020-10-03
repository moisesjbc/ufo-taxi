extends Area2D

onready var has_passengers: bool = true

func _on_pickup_area_body_entered(body):
	if body.name == 'player_train' and has_passengers:
		has_passengers = false
		body.pick_passenger()
