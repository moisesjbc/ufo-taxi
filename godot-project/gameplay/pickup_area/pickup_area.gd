extends Area2D

onready var has_passengers: bool = true

func _ready():
	update_label()

func _on_pickup_area_body_entered(body):
	# When playing level from level editor, pickup areas from editor are hiden
	# and replaced by realtime copies. Disable collisions for the not visible.
	if visible and body.name == 'player' and has_passengers:
		has_passengers = false
		update_label()
		body.pick_passenger()
		$pickup_sound.play()

func update_label():
	if has_passengers:
		$cow_label.set_text("1")
	else:
		$cow_label.set_text("0")
