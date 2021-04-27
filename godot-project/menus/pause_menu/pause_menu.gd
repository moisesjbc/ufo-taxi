extends Control


func start():
	get_tree().paused = true
	$pause_button.pressed = true
	$center_container.visible = true
	$center_container/panel/margin_container/vbox_container/level_label.text = 'Level ' + str(campaign_manager.current_campaign_index + 1) + ' - ' + str(campaign_manager.current_level_index + 1)


func stop():
	get_tree().paused = false
	$pause_button.pressed = false
	$center_container.visible = false


func _on_resume_button_pressed():
	stop()


func _on_pause_button_pressed():
	start()


func _on_return_button_pressed():
	stop()
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _physics_process(delta):
	if get_tree().paused and Input.is_action_just_pressed("ui_accept"):
		stop()


func _on_pause_button_toggled(button_pressed):
	if button_pressed:
		start()
	else:
		stop()
