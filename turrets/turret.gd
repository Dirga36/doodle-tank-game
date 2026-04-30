extends Node2D

@onready var muzzle: Marker2D = $Marker2D

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	_normalize_rotation()


func _normalize_rotation() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
