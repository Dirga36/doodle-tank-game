extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health = 3
@onready var current_health = max_health

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var player: CharacterBody2D = Global.player_node

func _physics_process(_delta):
	if player:
		# Calculate direction from enemy to player
		var direction: Vector2 = global_position.direction_to(player.global_position)
		
		# Set velocity and move
		velocity = direction * speed
		move_and_slide()

func take_damage(amount):
	current_health -= amount
	
	if current_health <= 0:
		die()

func die():
	# Disable collisions so dead enemies don't block the player
	collision_shape.set_deferred("disabled", true) 
	queue_free()
