extends Area2D

@export var speed: float = 700.0
@export var damage_amount = 1

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body):
	# Check if the body hit can take damage
	if body.has_method("take_damage"):
		body.take_damage(damage_amount)
		queue_free() # Destroy the bullet on impact
