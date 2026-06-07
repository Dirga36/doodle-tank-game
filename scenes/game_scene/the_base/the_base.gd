extends StaticBody2D

@export var max_health = 30
var health = max_health

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

	
func take_damage(amount):
	health -= amount
	print("the_base: -", amount)
	if health <= 0:
		die()

func die():
	queue_free()
