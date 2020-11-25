extends HBoxContainer

signal play_button_pressed
signal edit_button_pressed


func set_level_info(level_index: int, level_id: int):
	$play_button.text = str(level_index)
	if user_data.level_passed(level_id):
		$play_button.text = $play_button.text + ' [passed]'


func _on_play_button_pressed():
	emit_signal('play_button_pressed')


func _on_edit_button_pressed():
	emit_signal('edit_button_pressed')
