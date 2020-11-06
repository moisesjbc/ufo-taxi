extends KinematicBody2D

var path: Node2D = null
var current_node_index: int = 0
var next_node_index: int = 1
export var speed: int = 200
var n_passengers: int = 0

signal game_over

func _ready():
	set_physics_process(false)

func reset(path):
	current_node_index = 0
	next_node_index = 1
	n_passengers = 0
	set_physics_process(true)
	self.path = path
	position = path.nodes[0]
	update_passengers_label()
	
func change_next_node():
	# Update current node index
	current_node_index = current_node_index + 1
	if current_node_index >= len(path.nodes):
		current_node_index = 0
	
	# Update next node index
	next_node_index = next_node_index + 1
	if next_node_index >= len(path.nodes):
		next_node_index = 0
	
func _physics_process(delta):
	# Compute velocity
	var velocity = path.nodes[next_node_index] - path.nodes[current_node_index]
	$sprite_body.rotate(0.01)

	if position.distance_to(path.nodes[next_node_index]) > speed * delta:
		# Train is still far to next node. Advance.
		move_and_collide(velocity.normalized() * speed * delta)
	else:
		# Trail is very close to the next node. Advance to its position and
		# change to next node.
		move_and_collide(velocity.normalized() * position.distance_to(path.nodes[next_node_index]))
		change_next_node()


func _on_railtrack_node_removed(node_index):
	if node_index <= current_node_index:
		current_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(path.nodes) - 1
		
	if 	node_index <= next_node_index:
		next_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(path.nodes) - 1


func _on_railtrack_node_added(node_index):
	if node_index <= current_node_index:
		current_node_index = path.get_next_index(current_node_index)
	if node_index <= next_node_index:
		next_node_index = path.get_next_index(next_node_index)

func pick_passenger():
	n_passengers += 1
	update_passengers_label()
	
func leave_passengers():
	n_passengers = 0
	update_passengers_label()
	
func update_passengers_label():
	$passengers_label.set_text(str(n_passengers))

func die():
	emit_signal("game_over")
