extends Control


func start():
	get_tree().paused = true
	$center_container.visible = true


func stop():
	get_tree().paused = false
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
