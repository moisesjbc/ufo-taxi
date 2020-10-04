extends Control

signal restart_level_requested

func _ready():
	visible = false


func display():
	get_tree().paused = true
	visible = true


func _on_restart_level_button_pressed():
	get_tree().paused = false
	visible = false
	emit_signal("restart_level_requested")
