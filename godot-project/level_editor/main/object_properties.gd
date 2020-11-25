extends Panel

var current_object = null


func set_current_object(current_object):
	self.current_object = current_object
	if current_object:
		$margin_container/vbox_container/title.text = current_object.name
	visible = current_object != null


func _on_delete_button_pressed():
	self.current_object.queue_free()
	set_current_object(null)
