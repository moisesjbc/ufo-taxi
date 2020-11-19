extends HBoxContainer

signal play_button_pressed

func set_level_info(level_index: int, level_id: int):
	$play_button.text = str(level_index)


func _on_play_button_pressed():
	emit_signal('play_button_pressed')
