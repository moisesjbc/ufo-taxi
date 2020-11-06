extends Node

var current_state = null
var player = null
var railtrack = null

func change_state(new_state_name):
	if current_state and current_state.has_method('end'):
		current_state.end()
	current_state = get_node(new_state_name)
	current_state.state_machine = self
	current_state.railtrack = railtrack
	if current_state and current_state.has_method('start'):
		current_state.start()

func _physics_process(delta):
	if current_state and current_state.has_method('process'):
		current_state.process(delta)

func _input(event):
	if current_state and current_state.has_method('input'):
		current_state.input(event)
		
func _draw():
	if current_state or not player:
		if current_state and current_state.has_method('draw'):
			current_state.draw()
		else:
			$path._draw()
