extends Label

func set_warning(text):
	self.text = text
	visible = true
	$display_timer.start(2)
	set_physics_process(true)
	
func _physics_process(delta):
	set_global_position(get_global_mouse_position())

func _on_display_timer_timeout():
	text = ""
	visible = false
	set_physics_process(false)
