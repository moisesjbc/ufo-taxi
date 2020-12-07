extends Control


func set_volume(bus_name, value, min_volume, max_volume):
	value = min_volume + ((max_volume - min_volume) * (value / 100))
	if value != min_volume:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), true)


func _on_music_slider_value_changed(value):
	set_volume('Music', value, -30, 0)

func _on_sfx_slider_value_changed(value):
	set_volume('SFX', value, -30, -10)


func _on_play_sample_sound_pressed():
	$sample_sound.play()


func _on_return_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
