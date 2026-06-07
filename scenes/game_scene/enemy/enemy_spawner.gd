extends Node

@export var enemy_scene: PackedScene = preload("res://scenes/game_scene/enemy/enemy.tscn")
@export var spawn_count: int = 10
@onready var enemy_spawn_location: Marker2D = $"../Marker2D"

func _ready() -> void:
	if enemy_scene == null:
		push_warning("EnemySpawner: enemy_scene is not assigned.")
		return

	if enemy_spawn_location == null:
		push_warning("EnemySpawner: spawn Marker2D was not found.")
		return

	for i in range(spawn_count):
		var enemy = enemy_scene.instantiate()
		get_parent().add_child.call_deferred(enemy)
		if enemy is Node2D:
			enemy.global_position = enemy_spawn_location.global_position
		print("Spawned enemy #" + str(i + 1))
