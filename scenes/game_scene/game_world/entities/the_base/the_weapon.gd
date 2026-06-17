extends Node2D

@export var Bullet: CustomizablePackedScene
@export var fire_cooldown: float

@onready var Muzzle: Marker2D = $Muzzle
@onready var Radar: Area2D = $Radar

var _cooldown_timer: float


func _physics_process(delta: float) -> void:
	var closest_enemy := _get_closest_enemy_in_radar()
	if closest_enemy != null:
		look_at(closest_enemy.global_position)
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
	return _get_closest_enemy_in_radar() and _cooldown_timer == 0.0


func _get_closest_enemy_in_radar() -> Node2D:
	var closest_enemy = null
	var closest_distance := INF

	for body in Radar.get_overlapping_bodies():
		if body is Node2D and body.is_in_group("enemy"):
			var distance := global_position.distance_squared_to(body.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = body

	return closest_enemy


func _shoot() -> void:
	var bullet := Bullet.instantiate() as Area2D
	if bullet == null:
		return
	bullet.global_transform = Muzzle.global_transform
	var spawn_parent := get_tree().root
	spawn_parent.add_child(bullet)
	_cooldown_timer = fire_cooldown
