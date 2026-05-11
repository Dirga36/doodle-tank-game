extends Area2D

@export var speed: float = 700.0
@export var Bullet: PackedScene = preload("res://scenes/game_scene/player/bullet/bullet.tscn")

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visibility_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Enemy":
		print("hello enemy")

	
