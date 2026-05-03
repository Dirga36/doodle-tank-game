extends Node2D

@export var bullet_scene: PackedScene = preload("res://4005/bullet/bullet.tscn")
@export var shots_per_second: float = 0.5

@onready var muzzle: Marker2D = $Marker2D


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	_normalize_rotation()


func _normalize_rotation() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
