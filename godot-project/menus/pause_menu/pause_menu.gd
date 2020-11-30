extends Control


func start():
	get_tree().paused = true
	$center_container.visible = true
	$pause_button.visible = false


func stop():
	get_tree().paused = false
	$center_container.visible = false
	$pause_button.visible = true


func _on_resume_button_pressed():
	stop()


func _on_pause_button_pressed():
	start()


func _on_return_button_pressed():
	stop()
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
