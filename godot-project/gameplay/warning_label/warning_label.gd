extends Node2D

func set_warning(text):
	$color_rect/label.text = text
	$color_rect.rect_size.x = 15 * len(text)
	visible = true
	$display_timer.start(2)
	set_physics_process(true)
	
func _physics_process(delta):
	var mouse_global_position = get_global_mouse_position()
	if mouse_global_position.x < 800:
		set_global_position(get_global_mouse_position())
	else:
		set_global_position(get_global_mouse_position() - Vector2($color_rect.rect_size.x, 0))

func _on_display_timer_timeout():
	$color_rect/label.text = ""
	visible = false
	set_physics_process(false)
