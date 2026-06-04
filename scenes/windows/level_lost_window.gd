@tool
extends OverlaidWindow

@export_file("*.tscn") var main_menu_scene_path : String

func _ready():
	if OS.has_feature("web"):
		%ExitButton.hide()

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path

func _load_scene(scene_path: String) -> void:
	_scene_tree.paused = false
	SceneLoader.load_scene(scene_path)

func _on_exit_button_pressed():
	%ExitConfirmation.show()

func _on_main_menu_button_pressed():
	%MainMenuConfirmation.show()

func _on_close_button_pressed():
	SceneLoader.reload_current_scene()
	close()

func _on_main_menu_confirmation_confirmed():
	_load_scene(get_main_menu_scene_path())

func _on_exit_confirmation_confirmed():
	get_tree().quit()
