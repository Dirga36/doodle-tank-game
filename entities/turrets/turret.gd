extends Node2D

@export var bullet_scene: PackedScene = preload("res://entities/bullets/bullet.tscn")
@export var shots_per_second: float = 0.5

@onready var muzzle: Marker2D = $Marker2D
@onready var _animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	if _animated_sprite and not _animated_sprite.animation_finished.is_connected(_on_animated_sprite_animation_finished):
		_animated_sprite.animation_finished.connect(_on_animated_sprite_animation_finished)

var _cooldown: float = 0.0

func _physics_process(delta: float) -> void:
	_cooldown = max(_cooldown - delta, 0.0)
	look_at(get_global_mouse_position())
	_normalize_rotation()
	_try_shoot()


func _normalize_rotation() -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)


func _try_shoot() -> void:
	if not Input.is_action_pressed("shoot"):
		return
	if _cooldown > 0.0:
		return
	if bullet_scene == null:
		return

	_animated_sprite.play("shoot")
	var bullet: Area2D = bullet_scene.instantiate()
	bullet.global_transform = muzzle.global_transform
	get_tree().current_scene.add_child(bullet)

	_cooldown = 1.0 / max(shots_per_second, 0.01)


func _on_animated_sprite_animation_finished() -> void:
	_animated_sprite.stop()
	_animated_sprite.frame = 0
