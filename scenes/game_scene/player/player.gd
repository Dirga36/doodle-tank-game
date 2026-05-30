extends CharacterBody2D
signal player_die

@export var speed: float = 500.0
@export var rotation_speed: float = 2.0
@export var backward_multiplier: float = 0.6

@export var max_health: int = 40
@export var health: int = max_health

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	Global.player_node = self

var rotation_direction: float = 0.0
	
func get_input() -> void:
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	var throttle: float = Input.get_axis("move_backward", "move_forward")
	velocity = _get_drive_velocity(throttle)

func _get_drive_velocity(throttle: float) -> Vector2:
	if throttle < 0.0:
		throttle *= backward_multiplier
	return -throttle * speed * transform.y

func _physics_process(delta: float) -> void:
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func die():
	player_die.emit()
	print("Player died")

func take_damage(amount: int) -> void:
	health -= amount
	print("-", amount)
	if health <= 0:
		die()
