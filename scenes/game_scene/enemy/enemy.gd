extends CharacterBody2D

const speed: float = 100.0

var target = null
var is_dead := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if sprite.sprite_frames and sprite.sprite_frames.has_animation("death"):
		sprite.sprite_frames.set_animation_loop("death", false)
	if not sprite.animation_finished.is_connected(_on_animation_finished):
		sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return

	if target:
		_attack()
	else:
		velocity = Vector2.ZERO

	move_and_slide()
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
