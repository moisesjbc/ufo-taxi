extends Node2D

var state_machine = null
var main = null
var level_editor = null
var object = null

func start(object):
	level_editor.get_node('tools_container').visible = true
	self.object = object

func input(event):
	if event is InputEventMouseMotion:
		self.object.global_position = get_global_mouse_position()
		if self.object.has_method('update'):
			self.object.update()
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		state_machine.set_current_state('idle')
