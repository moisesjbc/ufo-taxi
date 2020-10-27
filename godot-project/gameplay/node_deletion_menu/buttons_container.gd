extends VBoxContainer

signal confirmed
signal cancelled


func _on_remove_button_pressed():
	emit_signal('confirmed')


func _on_cancel_button_pressed():
	emit_signal('cancelled')


func _input(event):
	# Emit cancelled signal if user clicks outside of the confirm button.
	if visible and (event is InputEventMouseButton or event is InputEventScreenTouch) and event.pressed \
		and not Rect2($hbox_container/remove_button.rect_global_position, $hbox_container/remove_button.rect_size).has_point(event.position):
			emit_signal('cancelled')
