extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0
var Bullet = preload("res://scenes/bullet.tscn")

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	# "Turret" is a Marker2D placed at the barrel of the gun.
	var b = Bullet.instantiate()
	b.start($PinJoint2D.global_position, rotation)
	get_tree().root.add_child(b)

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	var dir = get_global_mouse_position() - global_position
	rotation = dir.angle()
	move_and_slide()
