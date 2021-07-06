"""
Copyright 2020-2021 Moisés J. Bonilla Caraballo (moisesjbc)

This file is part of "UFO taxi!".

"UFO taxi!" is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

"UFO taxi!" is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with "UFO taxi!".  If not, see <https://www.gnu.org/licenses/>.
"""

extends Control

const MIN_VOLUME = -30
const MAX_VOLUME = 0


func _ready():
	update_fullscreen_button_label()
	$margin_container/vbox_container/options_container/music_container/music_slider.set_value(get_volume_slider_value('Music'))
	$margin_container/vbox_container/options_container/sfx_container/HBoxContainer/sfx_slider.set_value(get_volume_slider_value('SFX'))

func set_volume(bus_name, value, min_volume, max_volume):
	value = min_volume + ((max_volume - min_volume) * (value / 100))
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name), value == min_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), value)

func get_volume_slider_value(bus_name):
	var volume = AudioServer.get_bus_volume_db((AudioServer.get_bus_index(bus_name)))
	return ((volume - MIN_VOLUME) / float(MAX_VOLUME - MIN_VOLUME)) * 100

func _on_music_slider_value_changed(value):
	set_volume('Music', value, MIN_VOLUME, MAX_VOLUME)

func _on_sfx_slider_value_changed(value):
	set_volume('SFX', value, MIN_VOLUME, MAX_VOLUME)

func _on_play_sample_sound_pressed():
	$sample_sound.play()


func _on_return_button_pressed():
	scene_manager.change_scene("res://menus/main_menu/main_menu.tscn")


func _on_change_fullscreen_button_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	update_fullscreen_button_label()


func update_fullscreen_button_label():
	if OS.window_fullscreen:
		$margin_container/vbox_container/options_container/fullscreen_container/change_fullscreen_button.text = 'Fullscreen: ON'
	else:
		$margin_container/vbox_container/options_container/fullscreen_container/change_fullscreen_button.text = 'Fullscreen: OFF'
