extends Control

var level_options_scene = preload('res://menus/level_selector/level_options/level_options.tscn')

func _ready():
	campaign_manager.load_campaign_info(0)
	for level_index in range(len(campaign_manager.level_ids)):
		var level_option = level_options_scene.instance()
		level_option.set_level_info(level_index + 1, campaign_manager.level_ids[level_index], level_is_enabled(level_index))
		level_option.connect('play_button_pressed', self, '_play_level', [level_index])
		level_option.connect('edit_button_pressed', self, '_edit_level', [level_index])
		$margin_container/vbox_container/levels_container.add_child(level_option)
		$margin_container/vbox_container/levels_container.move_child(level_option, $margin_container/vbox_container/levels_container.get_child_count() - 2)
		
	# Only when playing from editor add button for adding a new level.
	# Source: <https://godotengine.org/qa/58519/check-if-game-is-exported>
	$margin_container/vbox_container/levels_container/add_level_button.visible = not OS.has_feature("standalone")


func level_is_enabled(level_index: int):
	var level_id = campaign_manager.level_ids[level_index]
	return level_index == 0 or user_data.level_passed(level_id) or user_data.level_passed(campaign_manager.level_ids[level_index - 1])


func _play_level(level_index):
	campaign_manager.load_level(0, level_index)
	get_tree().change_scene('res://gameplay/main/main.tscn')

func _edit_level(level_index: int):
	var level_id: int = campaign_manager.level_ids[level_index]
	level_manager.load_campaign_level_from_file(level_id)
	
	get_tree().change_scene("res://level_editor/main/level_editor.tscn")


func _on_return_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _on_add_level_button_pressed():
	# Right now we can rely on len(campaign_manager.level_ids) for calculating
	# the next free ID.
	# TODO: Change this calculation once we add new campaigns.
	var level_id: int = len(campaign_manager.level_ids)
	level_manager.create_campaign_level(level_id)
	campaign_manager.add_level(level_id)
	
	get_tree().change_scene("res://level_editor/main/level_editor.tscn")
