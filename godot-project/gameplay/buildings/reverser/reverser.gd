extends Area2D

var type = 'reverser'

func _on_reverser_body_entered(body):
	# Without the cooldown timer, reseting current level while player is on
	# this building would trigger this collision while building is generated
	# but still hasn't be placed on its final position.
	# When playing level from level editor, buildings from editor are hiden
	# and replaced by realtime copies. Disable collisions for the not visible.
	if $cooldown_timer.time_left <= 0.0 and visible and body.name == 'player':
		$cooldown_timer.start(1.0)
		body.reverse()
