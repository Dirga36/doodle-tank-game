extends Node2D

@export var Bullet: PackedScene = preload("res://player/bullet.tscn")
@export var fire_cooldown: float = 0.5
@onready var Muzzle: Marker2D = $Muzzle

var _cooldown_timer: float = 0.0


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	_normalize_rotation()
	_update_cooldown(delta)
	if _can_fire():
		_shoot()


func _normalize_rotation() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)


func _update_cooldown(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer = maxf(_cooldown_timer - delta, 0.0)


func _can_fire() -> bool:
	return Input.is_action_pressed("shoot") and _cooldown_timer == 0.0


func _shoot() -> void:
	if Bullet == null:
		return
	var bullet := Bullet.instantiate() as Area2D
	if bullet == null:
		return
	bullet.global_transform = Muzzle.global_transform
	var spawn_parent := get_tree().root
	spawn_parent.add_child(bullet)
	_cooldown_timer = fire_cooldown
