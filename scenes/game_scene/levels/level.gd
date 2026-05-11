extends Node

signal level_lost
signal level_won(level_path : String)
@warning_ignore("unused_signal")
signal level_changed(level_path : String)

## Optional path to the next level if using an open world level system.
@export_file("*.tscn") var next_level_path : String

var level_state : LevelState

func _on_lose_button_pressed() -> void:
	level_lost.emit()

func _on_win_button_pressed() -> void:
	level_won.emit(next_level_path)

func open_tutorials() -> void:
	%TutorialManager.open_tutorials()
	level_state.tutorial_read = true
	GlobalState.save()

func _ready() -> void:
	level_state = GameState.get_level_state(scene_file_path)
	%BackgroundColor.color = level_state.color
	if not level_state.tutorial_read:
		open_tutorials()
	_connect_player_death()

func _on_tutorial_button_pressed() -> void:
	open_tutorials()


func _connect_player_death() -> void:
	for player in get_tree().get_nodes_in_group("player"):
		if player.has_signal("died") and not player.died.is_connected(_on_player_died):
			player.died.connect(_on_player_died)


func _on_player_died() -> void:
	level_lost.emit()
