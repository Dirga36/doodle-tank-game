@tool
extends OverlaidWindow

signal continue_pressed
signal main_menu_pressed

@export_file("*.tscn") var ending_scene_path : String

func get_ending_scene_path() -> String:
	if ending_scene_path.is_empty():
		return AppConfig.ending_scene_path
	return ending_scene_path

func _load_scene(scene_path: String) -> void:
	_scene_tree.paused = false
	SceneLoader.load_scene(scene_path)

func _ready():
	if OS.has_feature("web"):
		%ExitButton.hide()

func _on_exit_button_pressed():
	%ExitConfirmation.show()

func _on_main_menu_button_pressed():
	%MainMenuConfirmation.show()

func _on_close_button_pressed():
	continue_pressed.emit()
	close()
	_load_scene(get_ending_scene_path())

func _on_main_menu_confirmation_confirmed():
	main_menu_pressed.emit()
	close()

func _on_exit_confirmation_confirmed():
	get_tree().quit()
