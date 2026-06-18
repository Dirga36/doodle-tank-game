extends CanvasLayer

func open_tutorials() -> void:
	$tutorial_manager.open_tutorials()

func _on_tutorial_button_pressed() -> void:
	open_tutorials()
