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

var campaign_options_scene = preload('res://menus/campaign_selector/campaign_options/campaign_options.tscn')

func _ready():
	var n_campaings = campaign_manager.get_number_of_campaigns()
	for campaign_index in range(n_campaings):
		var campaign_option = campaign_options_scene.instance()
		campaign_option.set_campaign_info(campaign_index + 1, campaign_is_enabled(campaign_index))
		campaign_option.connect('select_button_pressed', self, '_select_campaign', [campaign_index])
		$margin_container/vbox_container/campaigns_container.add_child(campaign_option)
		$margin_container/vbox_container/campaigns_container.move_child(campaign_option, $margin_container/vbox_container/campaigns_container.get_child_count() - 1)


func campaign_is_enabled(_campaign_index: int):
	# TODO: Implement
	return true


func _select_campaign(campaign_index):
	campaign_manager.set_current_campaign_index(campaign_index)
	campaign_manager.load_current_campaign_info()
	scene_manager.change_scene("res://menus/level_selector/level_selector.tscn")


func _on_return_button_pressed():
	scene_manager.change_scene("res://menus/main_menu/main_menu.tscn")
