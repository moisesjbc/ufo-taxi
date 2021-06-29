extends Area2D

var type = 'area_51'

func _on_area_51_body_entered(body):
	# On first iteration of level, area 51 is not on its final position and
	# could be colliding with the player. We add a small "cooldown" timer
	# for avoiding killing the player at the begining ;-)
	if $cooldown_timer.time_left <= 0 and body.name == 'player':
		body.die()
		$ufo_explosion_sound.play()
