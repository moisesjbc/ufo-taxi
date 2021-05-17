extends HBoxContainer

signal select_button_pressed


func set_campaign_info(campaign_index: int, enabled: bool):
	$select_button.text = str(campaign_index)
	if enabled:
		$select_button.disabled = false
		$select_button.text = $select_button.text
	else:
		$select_button.disabled = true
		$select_button.text = $select_button.text + ' [blocked]'


func _on_select_button_pressed():
	emit_signal('select_button_pressed')
