extends CharacterBody2D

signal health_changed(current_health: int, max_health: int)
signal died

@export var max_health: int = 30
@export var contact_damage: int = 10
@export var contact_damage_cooldown: float = 0.5

const speed: float = 100.0

var health: int = 0
var target = null
var is_dead := false
var _contact_timer: float = 0.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if sprite.sprite_frames and sprite.sprite_frames.has_animation("death"):
		sprite.sprite_frames.set_animation_loop("death", false)
	if not sprite.animation_finished.is_connected(_on_animation_finished):
		sprite.animation_finished.connect(_on_animation_finished)
	max_health = max(1, max_health)
	health = max_health
	add_to_group("enemies")
	health_changed.emit(health, max_health)

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return
	if _contact_timer > 0.0:
		_contact_timer = maxf(_contact_timer - delta, 0.0)

	if target:
		_attack()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	_apply_contact_damage()
	_update_animation()


func _attack() -> void:
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed


func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body


func _on_sight_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = null


func die() -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO
	sprite.play("death")
	died.emit()


func take_damage(amount: int) -> void:
	if is_dead or amount <= 0:
		return
	_set_health(health - amount)


func heal(amount: int) -> void:
	if is_dead or amount <= 0:
		return
	_set_health(health + amount)


func _set_health(value: int) -> void:
	health = clampi(value, 0, max_health)
	health_changed.emit(health, max_health)
	if health == 0:
		die()


func _update_animation() -> void:
	if is_dead:
		return

	if abs(velocity.x) > 0.01:
		sprite.flip_h = velocity.x < 0.0

	if velocity.length() > 0.1:
		if sprite.animation != "move":
			sprite.play("move")
	else:
		if sprite.animation != "idle":
			sprite.play("idle")


func _on_animation_finished() -> void:
	if is_dead and sprite.animation == "death":
		queue_free()


func _apply_contact_damage() -> void:
	if _contact_timer > 0.0:
		return
	var player := _get_player_collision()
	if player == null:
		return
	if player.has_method("take_damage"):
		player.take_damage(contact_damage)
	_contact_timer = contact_damage_cooldown


func _get_player_collision() -> Node2D:
	var collision_count := get_slide_collision_count()
	for collision_index in collision_count:
		var collision := get_slide_collision(collision_index)
		if collision == null:
			continue
		var collider := collision.get_collider()
		if collider is Node2D and collider.is_in_group("player"):
			return collider
	return null
