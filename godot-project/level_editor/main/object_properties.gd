extends Panel

var current_object = null
var level_editor = null

func set_current_object(current_object):
	self.current_object = current_object
	if current_object:
		$margin_container/vbox_container/title.text = current_object.name
		$margin_container/vbox_container/add_node_next_button.visible = current_object.is_in_group('nodes')
	visible = current_object != null


func _on_delete_button_pressed():
	self.current_object.queue_free()
	set_current_object(null)


func _on_add_node_next_button_pressed():
	var node_index: int = self.current_object.get_parent().get_node(self.current_object.name).get_index()
	level_editor.add_path_node_next(node_index)
