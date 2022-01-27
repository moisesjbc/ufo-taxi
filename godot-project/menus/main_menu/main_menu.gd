"""
Copyright 2020-2022 Moisés J. Bonilla Caraballo (moisesjbc)

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

func _ready():
	$margin_container/vbox_container/title_container/HBoxContainer/vbox_container/version.text = 'v' + config.GAME_VERSION
	if OS.get_name() == "HTML5":
		$margin_container/vbox_container/buttons_container/exit_button.visible = false


func _on_start_game_button_pressed():
	scene_manager.change_scene("res://menus/campaign_selector/campaign_selector.tscn")


func _on_options_menu_pressed():
	scene_manager.change_scene("res://menus/options_menu/options_menu.tscn")


func _on_credits_button_pressed():
	scene_manager.change_scene("res://menus/credits_menu/credits_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
