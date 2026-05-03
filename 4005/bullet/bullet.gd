extends Area2D

@export var speed: float = 700.0


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visibility_notifier_2d_screen_exited() -> void:
	queue_free()
