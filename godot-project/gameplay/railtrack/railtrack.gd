extends Node2D

var current_state = null
var player = null

signal node_removed
signal node_added
signal warning_added
signal n_remaining_actions_updated

var n_remaining_actions = null
var edit_mode: bool = false

func _ready():
	$state_machine.railtrack = self

func reset(nodes, n_remaining_actions, edit_mode, on_object_selected_target = null, on_object_selected_callback = null):
	$path.set_nodes(nodes, on_object_selected_target, on_object_selected_callback)
	self.n_remaining_actions = n_remaining_actions
	self.edit_mode = edit_mode
	if not edit_mode:
		player = $player
		player.reset($path)
	var destination_area = get_node('/root/main/railtrack/destination_area')
	emit_signal("n_remaining_actions_updated", n_remaining_actions)
	$state_machine.change_state("selection")
	$path.update()

func select_current_node():
	if $path.current_node != null:
		$state_machine.change_state("node_selected")
		
func confirm_current_selection():
	if $path.current_node != null:
		if $path.current_node:
			if n_remaining_actions != 0:
				$state_machine.change_state("node_selected")
			else:
				warning("No actions remaining!")
		else:
			warning("You can't move destination")
				
	elif $path.current_edge != null:
		if n_remaining_actions != 0:
			$state_machine.change_state("edge_selected")
		else:
			warning("No actions remaining!")

func remove_current_node():
	if $path.current_node != null:
		if $path.current_node != player.current_node_index and $path.current_node != $path.get_next_index(player.current_node_index):
			$path.remove_node($path.current_node)
			emit_signal("node_removed", $path.current_node)
			$path.current_node = null
			consume_action()
			$path.update()
		else:
			warning('Node in use!')

func add_node(new_position, on_node_selected_target = null, on_node_selected_callback = null):
	if $path.current_edge != player.current_node_index:
		#$path.nodes.insert($path.current_edge + 1, to_local(new_position))
		$path.add_node(to_local(new_position), $path.current_edge + 1, on_node_selected_target, on_node_selected_callback)
		emit_signal("node_added", $path.current_edge + 1)
		consume_action()
		$path.update()
	else:
		warning('Edge in use!')
		
	
func consume_action():
	if n_remaining_actions != null:
		n_remaining_actions -= 1
		emit_signal("n_remaining_actions_updated", n_remaining_actions)

func warning(text):
	emit_signal("warning_added", text)

func get_closest_node(mouse_position):
	return $path.get_closest_node(mouse_position)

func get_closest_edge(mouse_position, node_index, edge_selection_distance):
	return $path.get_closest_edge(mouse_position, node_index, edge_selection_distance)

func highlight_node(node):
	return $path.highlight_node(node)
	
func highlight_edge(edge):
	return $path.highlight_edge(edge)
