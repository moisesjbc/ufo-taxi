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


func campaign_is_enabled(campaign_index: int):
	# TODO: Implement
	return true


func _select_campaign(campaign_index):
	campaign_manager.set_current_campaign_index(campaign_index)
	campaign_manager.load_current_campaign_info()
	get_tree().change_scene("res://menus/level_selector/level_selector.tscn")


func _on_return_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
