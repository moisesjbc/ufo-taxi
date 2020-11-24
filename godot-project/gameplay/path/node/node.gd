extends Sprite

func _ready():
	modulate = Color.aquamarine

func set_selected(selected: bool):
	if selected:
		modulate = Color.blue
	else:
		modulate = Color.aquamarine
