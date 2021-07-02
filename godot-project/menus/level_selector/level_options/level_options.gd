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

extends HBoxContainer

signal play_button_pressed
signal edit_button_pressed


func _ready():
	# Only when playing from editor add button for editing the level level.
	# Source: <https://godotengine.org/qa/58519/check-if-game-is-exported>
	$edit_button.visible = not OS.has_feature("standalone")


func set_level_info(level_index: int, enabled: bool):
	$play_button.text = str(campaign_manager.current_campaign_index + 1) + ' - ' + str(level_index)
	if enabled:
		$play_button.disabled = false
		$play_button.text = $play_button.text
	else:
		$play_button.disabled = true
		$play_button.text = $play_button.text + ' [blocked]'


func _on_play_button_pressed():
	emit_signal('play_button_pressed')


func _on_edit_button_pressed():
	emit_signal('edit_button_pressed')
