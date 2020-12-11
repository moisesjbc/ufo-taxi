extends HBoxContainer

signal play_button_pressed
signal edit_button_pressed


func _ready():
	# Only when playing from editor add button for editing the level level.
	# Source: <https://godotengine.org/qa/58519/check-if-game-is-exported>
	$edit_button.visible = not OS.has_feature("standalone")


func set_level_info(level_index: int, level_id: int, enabled: bool):
	$play_button.text = str(level_index)
	if enabled:
		$play_button.disabled = false
		$play_button.text = $play_button.text
	else:
		$play_button.disabled = true
		$play_button.text = $play_button.text + ' [blocked]'


func _on_play_button_pressed():
	emit_signal('play_button_pressed')


func _on_edit_button_pressed():
	emit_signal('edit_button_pressed')
