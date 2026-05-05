extends "res://addons/maaacks_game_template/extras/scripts/win_lose_manager.gd"

func on_level_won(_next_level_path: String = "") -> void:
	game_won()

func on_level_lost() -> void:
	game_lost()
