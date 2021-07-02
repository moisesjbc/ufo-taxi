extends Node

func change_scene(scene_path):
	var error_code = get_tree().change_scene(scene_path)
	if error_code != 0:
		print('ERROR changing to scene ' + scene_path + ' - error code: ' + str(error_code))
