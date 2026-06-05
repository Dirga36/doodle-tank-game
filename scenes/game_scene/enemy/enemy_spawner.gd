extends Node

@export var enemy_scene: PackedScene = preload("res://scenes/game_scene/enemy/enemy.tscn")

func _on_enemy_timer_timeout() -> void:
	# Create a new instance of the enemy scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var enemy_spawn_location = $"../Node/EnemyPath/EnemySpawnLocation"
	enemy_spawn_location.progress_ratio = randf()

	# Set the enemy position to the random location.
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
