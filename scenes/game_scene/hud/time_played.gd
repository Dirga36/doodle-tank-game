extends Label

const TIME_FORMAT := "%02d:%02d"

@onready var _game_timer := _resolve_game_timer()
var _update_timer: Timer

func _ready() -> void:
	_update_timer = Timer.new()
	_update_timer.one_shot = false
	_update_timer.wait_time = 1.0
	_update_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	_update_timer.timeout.connect(_update_label)
	add_child(_update_timer)
	_update_label()
	_update_timer.start()

func _resolve_game_timer() -> Node:
	return get_node_or_null("../../../../../../GameTimer")

func _update_label() -> void:
	if _game_timer == null:
		text = "00:00"
		return
	var seconds: int = _game_timer.play_time
	@warning_ignore("integer_division")
	var minutes: int = seconds / 60
	var remainder: int = seconds % 60
	text = TIME_FORMAT % [minutes, remainder]
