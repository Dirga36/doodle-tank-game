extends Area2D

@export var speed: float = 700.0

@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibilityNotifier2D

func _ready() -> void:
	if not screen_notifier.screen_exited.is_connected(_on_visible_on_screen_notifier_2d_screen_exited):
		screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)

func _physics_process(delta: float) -> void:
	global_position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
