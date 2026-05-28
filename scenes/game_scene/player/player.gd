extends CharacterBody2D

@export var speed: float = 500.0
@export var rotation_speed: float = 2.0
@export var backward_multiplier: float = 0.6

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	Global.player_node = self

var health: int = 0
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
