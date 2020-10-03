extends Control

signal continue_pressed


func display():
	visible = true
	get_tree().paused = true


func _on_continue_button_pressed():
	visible = false
	get_tree().paused = false
	emit_signal('continue_pressed')
