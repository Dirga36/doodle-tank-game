extends Node

signal game_win

const WIN_PLAY_TIME_SECONDS := 20 * 60

@onready var _game_timer := get_node_or_null("../GameTimer")
var _has_won := false
var _check_timer: Timer

func _ready() -> void:
	_check_timer = Timer.new()
	_check_timer.one_shot = false
	_check_timer.wait_time = 1.0
	_check_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	_check_timer.timeout.connect(main_objective_completed)
	add_child(_check_timer)
	_check_timer.start()

func win():
	game_win.emit()
	
func main_objective_completed():
	if _has_won:
		return
	if _game_timer == null:
		return
	if _game_timer.play_time >= WIN_PLAY_TIME_SECONDS:
		_has_won = true
		win()
