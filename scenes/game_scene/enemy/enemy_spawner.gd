extends Node

@export var enemy_scene: PackedScene = preload("res://scenes/game_scene/enemy/enemy.tscn")


func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
