extends Camera2D

@export var zoom_speed: float
@export var min_zoom: float
@export var max_zoom: float

var target_zoom: Vector2 = Vector2(1.0, 1.0)

func _ready() -> void:
	target_zoom = zoom

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				target_zoom += Vector2(zoom_speed, zoom_speed)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				target_zoom -= Vector2(zoom_speed, zoom_speed)
			
			# Clamp the zoom so it stays within reasonable limits
			target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
			target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)

func _process(_delta: float) -> void:
	# Lerp (linear interpolation) creates a smooth zooming effect
	zoom = zoom.lerp(target_zoom, 0.1)
