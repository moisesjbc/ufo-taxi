extends Node2D

var state_machine = null
var level_editor = null
var object = null
var popup = null

func start(object):
	self.object = object

	popup = PopupMenu.new()
	popup.add_item("Delete")
	popup.set_global_position(self.object.global_position + Vector2(15, 15))
	add_child(popup)
	popup
	popup.connect("id_pressed", self, "_on_item_pressed")
	
func stop():
	if popup:
		popup.queue_free()
	
func _on_item_pressed(id):
	if id == 0:
		state_machine.set_current_state('idle')
		self.object.queue_free()
