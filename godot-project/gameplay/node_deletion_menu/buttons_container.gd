extends VBoxContainer

signal confirmed
signal cancelled


func _on_remove_button_pressed():
	emit_signal('confirmed')


func _on_cancel_button_pressed():
	emit_signal('cancelled')
