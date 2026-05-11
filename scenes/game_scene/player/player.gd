extends CharacterBody2D

signal health_changed(current_health: int, max_health: int)
signal died

@export var max_health: int = 100
@export var speed: float = 250.0
@export var rotation_speed: float = 2.0
@export var backward_multiplier: float = 0.6

var health: int = 0
var rotation_direction: float = 0.0
var is_dead := false

func _ready() -> void:
	max_health = max(1, max_health)
	health = max_health
	add_to_group("player")
	health_changed.emit(health, max_health)

func get_input() -> void:
	rotation_direction = Input.get_axis("left", "right")
	var throttle: float = Input.get_axis("down", "up")
	velocity = _get_drive_velocity(throttle)

func _get_drive_velocity(throttle: float) -> Vector2:
	if throttle < 0.0:
		throttle *= backward_multiplier
	return -throttle * speed * transform.y

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()


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


func die() -> void:
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	died.emit()
