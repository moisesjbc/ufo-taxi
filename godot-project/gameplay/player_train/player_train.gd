extends KinematicBody2D

var railtrack: Node2D = null
var current_node_index: int = 0
var next_node_index: int = 1
export var speed: int = 200
var n_passengers: int = 0

func _ready():
	set_physics_process(false)

func reset(railtrack):
	set_physics_process(true)
	self.railtrack = railtrack
	position = railtrack.nodes[0]
	update_passengers_label()
	
func change_next_node():
	# Update current node index
	current_node_index = current_node_index + 1
	if current_node_index >= len(railtrack.nodes):
		current_node_index = 0
	
	# Update next node index
	next_node_index = next_node_index + 1
	if next_node_index >= len(railtrack.nodes):
		next_node_index = 0
	
func _physics_process(delta):
	# Compute velocity
	var velocity = railtrack.nodes[next_node_index] - railtrack.nodes[current_node_index]

	if position.distance_to(railtrack.nodes[next_node_index]) > speed * delta:
		# Train is still far to next node. Advance.
		move_and_collide(velocity.normalized() * speed * delta)
	else:
		# Trail is very close to the next node. Advance to its position and
		# change to next node.
		move_and_collide(velocity.normalized() * position.distance_to(railtrack.nodes[next_node_index]))
		change_next_node()


func _on_railtrack_node_removed(node_index):
	if node_index <= current_node_index:
		current_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(railtrack.nodes) - 1
		
	if 	node_index <= next_node_index:
		next_node_index -= 1
		if current_node_index < 0:
			current_node_index = len(railtrack.nodes) - 1


func _on_railtrack_node_added(node_index):
	if node_index <= current_node_index:
		current_node_index = railtrack.get_next_index(current_node_index)
	if node_index <= next_node_index:
		next_node_index = railtrack.get_next_index(next_node_index)

func pick_passenger():
	n_passengers += 1
	update_passengers_label()
	
func leave_passengers():
	n_passengers = 0
	update_passengers_label()
	
func update_passengers_label():
	$passengers_label.text = str(n_passengers) + " passenger(s)"
