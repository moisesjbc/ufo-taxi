extends Area2D

onready var has_passengers: bool = true

func _ready():
	update_label()

func _on_pickup_area_body_entered(body):
	if body.name == 'player_train' and has_passengers:
		has_passengers = false
		update_label()
		body.pick_passenger()

func update_label():
	if has_passengers:
		$cow_label.set_text("1")
	else:
		$cow_label.set_text("0")
