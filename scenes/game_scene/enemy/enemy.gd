extends CharacterBody2D

@export var speed: float
@export var max_health: int
@export var health: int
@export var damage: int

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var the_base = Global.the_base_node
@onready var attack_cooldown: Timer = $"AttackCooldown"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var polygon_2d: Polygon2D = $Polygon2D

var can_attack: bool = true
var target_in_range: bool = false

func _physics_process(_delta):
	# Calculate direction from enemy to the_base
	var direction: Vector2 = global_position.direction_to(the_base.global_position)
		
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

func _do_attack(target) -> void:
	if not can_attack:
		return
	can_attack = false
	target.take_damage(damage)
	attack_cooldown.start()

func _on_hitbox_body_entered(body) -> void:
	if body.is_in_group("ally"):
		target_in_range = true
		_do_attack(body)

func _on_hitbox_body_exited(body) -> void:
	if body.is_in_group("ally"):
		target_in_range = false

func _on_attack_cooldown_timeout() -> void:
	can_attack = true
	if target_in_range and the_base:
		_do_attack(the_base)
