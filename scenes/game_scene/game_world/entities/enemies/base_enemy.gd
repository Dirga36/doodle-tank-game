extends CharacterBody2D

@export var speed: float
@export var max_health: int
@export var health: int
@export var damage: int

@onready var player = Global.player_node
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var polygon_2d: Polygon2D = $Polygon2D


func _physics_process(_delta):
	# Calculate direction from enemy to player
	var direction: Vector2 = global_position.direction_to(player.global_position)
		
	# Set velocity and move
	velocity = direction * speed
	move_and_slide()

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	# 1. Disable collisions to stop further interactions
	polygon_2d.hide()
	collision_shape.set_deferred("disabled", true)
	speed = 0
	
	# 2. Play the death animation
	animated_sprite_2d.play("death")
	
	# 3. Wait for the animation to finish before deleting the node
	await animated_sprite_2d.animation_finished
	queue_free()
