extends Area2D

@export var speed: float
@export var damage: int

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body):
	# Check if the body is the enemy's body
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free() # Destroy the bullet on impact
