extends Control

var level_options_scene = preload('res://menus/level_selector/level_options/level_options.tscn')

func _ready():
	campaign_manager.load_campaign_info(0)
	for level_index in range(len(campaign_manager.level_ids)):
		var level_option = level_options_scene.instance()
		level_option.set_level_info(level_index + 1, campaign_manager.level_ids[level_index])
		level_option.connect('play_button_pressed', self, '_play_level', [level_index])
		$margin_container/vbox_container/levels_container.add_child(level_option)

func _play_level(level_index):
	campaign_manager.load_level(0, level_index)
	get_tree().change_scene('res://gameplay/main/main.tscn')
