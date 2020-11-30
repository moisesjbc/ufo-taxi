extends Control

var level_options_scene = preload('res://menus/level_selector/level_options/level_options.tscn')

func _ready():
	campaign_manager.load_campaign_info(0)
	for level_index in range(len(campaign_manager.level_ids)):
		var level_option = level_options_scene.instance()
		level_option.set_level_info(level_index + 1, campaign_manager.level_ids[level_index])
		level_option.connect('play_button_pressed', self, '_play_level', [level_index])
		level_option.connect('edit_button_pressed', self, '_edit_level', [level_index])
		$margin_container/vbox_container/levels_container.add_child(level_option)
		
	# Only when playing from editor add button for adding a new level.
	# Source: <https://godotengine.org/qa/58519/check-if-game-is-exported>
	if not OS.has_feature("standalone"):
		var add_level_button = Button.new()
		add_level_button.text = 'Add level'
		add_level_button.connect('pressed', self, '_add_level')
		$margin_container/vbox_container/levels_container.add_child(add_level_button)

func _play_level(level_index):
	campaign_manager.load_level(0, level_index)
	get_tree().change_scene('res://gameplay/main/main.tscn')

func _add_level():
	# Right now we can rely on len(campaign_manager.level_ids) for calculating
	# the next free ID.
	# TODO: Change this calculation once we add new campaigns.
	var level_id: int = len(campaign_manager.level_ids)
	level_manager.create_campaign_level(level_id)
	campaign_manager.add_level(level_id)
	
	get_tree().change_scene("res://level_editor/main/level_editor.tscn")


func _edit_level(level_index: int):
	var level_id: int = campaign_manager.level_ids[level_index]
	level_manager.load_campaign_level_from_file(level_id)
	
	get_tree().change_scene("res://level_editor/main/level_editor.tscn")


func _on_return_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
