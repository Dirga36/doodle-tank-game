extends Area2D

@export var speed: float
@export var damage: int

@onready var bullet_particle = preload("res://scenes/game_scene/allied_projectile/bullet_particle.tscn")

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body):
	# Check if the body is the enemy's body
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		var bullet_effect = bullet_particle.instantiate()
		get_tree().root.add_child(bullet_effect)
		bullet_effect.setup(global_transform)
		queue_free() # Destroy the bullet on impact

func _on_lifespan_timeout() -> void:
	queue_free() # Deletes the bullet when time runs out
