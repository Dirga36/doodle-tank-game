extends StaticBody2D
signal base_destroyed

@export var max_health: int
@export var health: int

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	Global.the_base_node = self

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	animated_sprite_2d.play("destroyed")
	await animated_sprite_2d.animation_finished
	queue_free()
	base_destroyed.emit()
	
