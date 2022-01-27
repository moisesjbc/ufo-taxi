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

extends HBoxContainer

signal select_button_pressed


func set_campaign_info(campaign_index: int, enabled: bool):
	$select_button.text = str(campaign_index)
	if enabled:
		$select_button.disabled = false
		$select_button.text = $select_button.text
	else:
		$select_button.disabled = true
		$select_button.text = $select_button.text + ' [blocked]'


func _on_select_button_pressed():
	emit_signal('select_button_pressed')
