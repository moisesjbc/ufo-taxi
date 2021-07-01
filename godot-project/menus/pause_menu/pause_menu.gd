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


func start():
	get_tree().paused = true
	$pause_button.pressed = true
	$center_container.visible = true
	$center_container/panel/margin_container/vbox_container/level_label.text = 'Level ' + str(campaign_manager.current_campaign_index + 1) + ' - ' + str(campaign_manager.current_level_index + 1)


func stop():
	get_tree().paused = false
	$pause_button.pressed = false
	$center_container.visible = false


func _on_resume_button_pressed():
	stop()


func _on_pause_button_pressed():
	start()


func _on_return_button_pressed():
	stop()
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _physics_process(delta):
	if get_tree().paused and Input.is_action_just_pressed("ui_accept"):
		stop()


func _on_pause_button_toggled(button_pressed):
	if button_pressed:
		start()
	else:
		stop()
