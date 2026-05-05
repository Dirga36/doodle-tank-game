extends CharacterBody2D

const speed: float = 100.0

var target = null


func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)
	look_at(get_global_mouse_position())


func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * speed * delta


func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body


func _on_sight_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = null
