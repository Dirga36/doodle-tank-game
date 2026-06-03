extends TextureRect

const HEALTH_TEXTURES: Array[Texture2D] = [
	preload("res://assets/images/HUD/Healthbar/0.png"),
	preload("res://assets/images/HUD/Healthbar/10.png"),
	preload("res://assets/images/HUD/Healthbar/20.png"),
	preload("res://assets/images/HUD/Healthbar/30.png"),
	preload("res://assets/images/HUD/Healthbar/40.png"),
]

var player = null
var _last_health: int = -1

func _ready() -> void:
	_resolve_player()
	_update_healthbar()
	set_process(true)
	
	

func _process(_delta: float) -> void:
	if not is_instance_valid(player):
		_resolve_player()
		return
	if player.health != _last_health:
		_update_healthbar()

func _resolve_player() -> void:
	player = Global.player_node

func _update_healthbar() -> void:
	if not is_instance_valid(player):
		return
	var current_health: int = player.health
	var max_health: int = max(player.max_health, 1)
	_last_health = current_health
	var texture_index: int = _health_to_index(current_health, max_health)
	texture = HEALTH_TEXTURES[texture_index]

func _health_to_index(current_health: int, max_health: int) -> int:
	if current_health <= 0:
		return 0
	var ratio := float(current_health) / float(max_health)
	var index := int(ceil(ratio * 4.0))
	return clamp(index, 1, 4)
