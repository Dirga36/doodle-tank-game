extends CharacterBody2D

@export var move_speed: float = 120.0
@export var turn_speed: float = 90.0       # degrees per second
@export var turret_track_speed: float = 8.0  # lerp factor

var turret_angle: float = 0.0

func _physics_process(delta: float) -> void:
	# --- Hull rotation (A/D) ---
	var turn_input = Input.get_axis("turn_left", "turn_right")
	rotation += deg_to_rad(turn_speed) * turn_input * delta

	# --- Forward/back movement along hull facing ---
	var drive_input = Input.get_axis("move_backward", "move_forward")
	velocity = Vector2.RIGHT.rotated(rotation) * move_speed * drive_input
	move_and_slide()

	# --- Turret tracks mouse ---
	var mouse_pos = get_global_mouse_position()
	var target_angle = global_position.angle_to_point(mouse_pos)
	turret_angle = lerp_angle(turret_angle, target_angle, turret_track_speed * delta)

func _draw() -> void:
	# Hull (drawn relative to node origin)
	draw_rect(Rect2(-22, -14, 44, 28), Color.DARK_GREEN)
	# Turret (rotated separately)
	draw_set_transform(Vector2.ZERO, turret_angle - rotation)
	draw_circle(Vector2.ZERO, 11, Color.OLIVE)
	draw_line(Vector2.ZERO, Vector2(24, 0), Color.YELLOW, 3.0)
