extends Node2D

@export var Bullet: PackedScene = preload("res://player/bullet/bullet.tscn")
@onready var Muzzle: Marker2D = $Muzzle


func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	_normalize_rotation()
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _normalize_rotation() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)


func shoot():
	var bullet_instance = Bullet.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = Muzzle.global_position
	bullet_instance.rotation = rotation
