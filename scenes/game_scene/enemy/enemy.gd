extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health = 30
@export var health = max_health
@export var damage = 10

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var player: CharacterBody2D = Global.player_node
@onready var attack_cooldown: Timer = $"AttackCooldown"

var can_attack: bool = true
var player_in_range: bool = false

func _physics_process(_delta):
	if player:
		# Calculate direction from enemy to player
		var direction: Vector2 = global_position.direction_to(player.global_position)
		
		# Set velocity and move
		velocity = direction * speed
		move_and_slide()

func take_damage(amount):
	health -= amount
	print("enemy: -", amount)
	if health <= 0:
		die()

func die():
	# Disable collisions so dead enemies don't block the player
	collision_shape.set_deferred("disabled", true) 
	queue_free()

func _do_attack(target: CharacterBody2D) -> void:
	if not can_attack:
		return
	can_attack = false
	target.take_damage(damage)
	attack_cooldown.start()

func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		player_in_range = true
		_do_attack(body)

func _on_hitbox_body_exited(body: CharacterBody2D) -> void:
	if body.name == "Player":
		player_in_range = false

func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	if player_in_range and player:
		_do_attack(player)
