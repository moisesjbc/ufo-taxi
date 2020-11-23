extends Node2D

var current_state = null


func _ready():
	set_current_state('idle')


func set_current_state(new_state_name, arg=null):
	var new_state = get_node(new_state_name)

	if current_state:
		for child in current_state.get_children():
			child.visible = false
		if current_state.has_method('stop'):
			current_state.stop()
	
	current_state = new_state
	
	current_state.state_machine = self
	current_state.level_editor = self.get_parent()
	current_state.main = self.get_parent().get_node('main')
	
	if current_state:
		if current_state.has_method('start'):
			if arg:
				current_state.start(arg)
			else:
				current_state.start()
		for child in current_state.get_children():
			child.visible = true


func _physics_process(delta):
	if current_state and current_state.has_method('physics_process'):
		current_state.physics_process(delta)

func _input(event):
	if current_state and current_state.has_method('input'):
		current_state.input(event)
