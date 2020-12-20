extends Control

func _ready():
	$margin_container/vbox_container/title_container/HBoxContainer/vbox_container/version.text = 'v' + config.GAME_VERSION
	if OS.get_name() == "HTML5":
		$margin_container/vbox_container/buttons_container/exit_button.visible = false


func _on_start_game_button_pressed():
	get_tree().change_scene("res://menus/level_selector/level_selector.tscn")


func _on_options_menu_pressed():
	get_tree().change_scene("res://menus/options_menu/options_menu.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene("res://menus/credits_menu/credits_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
