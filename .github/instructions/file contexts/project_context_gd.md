# [Doodle Tank] Project Context File: .gd

## res://

**global.gd**
```gdscript
extends Node

var player_node
var the_base_node

```

### scenes

#### credits

**scrollable_credits.gd**
```gdscript
@tool
extends Control

@onready var credits_label : RichTextLabel = %CreditsLabel

@export var input_scroll_speed : float = 10.0

var _line_number : float = 0

func _on_visibility_changed() -> void:
	if visible:
		credits_label.scroll_to_line(0)
		credits_label.grab_focus()

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)

func _process(delta : float) -> void:
	if Engine.is_editor_hint() or not visible:
		return
	var input_axis = Input.get_axis("ui_up", "ui_down")
	if abs(input_axis) > 0.5:
		_line_number += input_axis * delta * input_scroll_speed
		var max_lines = credits_label.get_line_count() - credits_label.get_visible_line_count()
		if _line_number < 0:
			_line_number = 0
		if _line_number > max_lines:
			_line_number = max_lines
		credits_label.scroll_to_line(round(_line_number))

```

**scrolling_credits.gd**
```gdscript
@tool
extends Control

signal end_reached

@export var auto_scroll_speed: float = 60.0
@export var input_scroll_speed : float = 400.0
@export var scroll_restart_delay : float = 1.5
@export var scroll_paused : bool = false

var timer : Timer = Timer.new()
var _current_scroll_position : float = 0.0

@onready var header_space : Control = %HeaderSpace
@onready var footer_space : Control = %FooterSpace
@onready var credits_label : Control = %CreditsLabel
@onready var scroll_container : ScrollContainer = %ScrollContainer

func set_header_and_footer() -> void:
	header_space.custom_minimum_size.y = size.y
	footer_space.custom_minimum_size.y = size.y
	credits_label.custom_minimum_size.x = size.x

func _on_resized() -> void:
	set_header_and_footer()
	_current_scroll_position = scroll_container.scroll_vertical

func _end_reached() -> void:
	scroll_paused = true
	end_reached.emit()

func is_end_reached() -> bool:
	var _end_of_credits_vertical = credits_label.size.y + header_space.size.y
	return scroll_container.scroll_vertical > _end_of_credits_vertical

func _check_end_reached() -> void:
	if not is_end_reached():
		return
	_end_reached()

func _scroll_container(amount : float) -> void:
	if not visible or scroll_paused:
		return
	_current_scroll_position += amount
	scroll_container.scroll_vertical = round(_current_scroll_position)
	_check_end_reached()

func _on_gui_input(event : InputEvent) -> void:
	# Captures the mouse scroll wheel input event
	if event is InputEventMouseButton:
		scroll_paused = true
		_start_scroll_restart_timer()
	_check_end_reached()

func _on_scroll_started() -> void:
	# Captures the touch input event
	scroll_paused = true
	_start_scroll_restart_timer()

func _start_scroll_restart_timer() -> void:
	timer.start(scroll_restart_delay)

func _on_scroll_restart_timer_timeout() -> void:
	_current_scroll_position = scroll_container.scroll_vertical
	scroll_paused = false

func _on_visibility_changed() -> void:
	if visible:
		scroll_container.scroll_vertical = 0
		_current_scroll_position = scroll_container.scroll_vertical
		scroll_paused = false

func _ready() -> void:
	scroll_container.scroll_started.connect(_on_scroll_started)
	gui_input.connect(_on_gui_input)
	resized.connect(_on_resized)
	visibility_changed.connect(_on_visibility_changed)
	timer.timeout.connect(_on_scroll_restart_timer_timeout)
	set_header_and_footer()
	add_child(timer)
	scroll_paused = false


func _process(delta : float) -> void:
	var input_axis = Input.get_axis("ui_up", "ui_down")
	if input_axis != 0:
		_scroll_container(input_axis * input_scroll_speed * delta)
	else:
		_scroll_container(auto_scroll_speed * delta)

func _exit_tree() -> void:
	_current_scroll_position = scroll_container.scroll_vertical

```

#### end_credits

**end_credits.gd**
```gdscript
@tool
extends "res://scenes/credits/scrolling_credits.gd"

## Defines the path to the main menu. Hides the Main Menu button if not set.
## Will attempt to read from AppConfig if left empty.
@export_file("*.tscn") var main_menu_scene_path : String
## This option forces the mouse to be visible when the menu shows up.
## Useful for games that capture the mouse, and don't automatically return it.
@export var force_mouse_mode_visible : bool = false

@onready var end_message_panel = %EndMessagePanel
@onready var exit_button = %ExitButton
@onready var menu_button = %MenuButton
@onready var init_mouse_filter : MouseFilter = mouse_filter

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path

func _end_reached() -> void:
	end_message_panel.show()
	mouse_filter = Control.MOUSE_FILTER_STOP
	if force_mouse_mode_visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	super._end_reached()

func load_main_menu() -> void:
	SceneLoader.load_scene(get_main_menu_scene_path())

func exit_game() -> void:
	if OS.has_feature("web"):
		load_main_menu()
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		end_message_panel.hide()
		mouse_filter = init_mouse_filter
	super._on_visibility_changed()

func _ready() -> void:
	if get_main_menu_scene_path().is_empty():
		menu_button.hide()
	if OS.has_feature("web"):
		exit_button.hide()
	end_message_panel.hide()
	super._ready()

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		if not end_message_panel.visible:
			_end_reached()
		else:
			exit_game()

func _on_exit_button_pressed():
	exit_game()

func _on_menu_button_pressed():
	load_main_menu()

```

#### game_scene

**configurable_sub_viewport.gd**
```gdscript
extends SubViewport
## Script to apply the anti-aliasing setting from [PlayerConfig] to a [SubViewport].

## The name of the anti-aliasing variable in the [ConfigFile].
@export var anti_aliasing_key : StringName = "Anti-aliasing"
## The name of the section of the anti-aliasing variable in the [ConfigFile].
@export var video_section : StringName = AppSettings.VIDEO_SECTION

func _ready() -> void:
	var anti_aliasing : int = PlayerConfig.get_config(video_section, anti_aliasing_key, Viewport.MSAA_DISABLED)
	msaa_2d = anti_aliasing as MSAA
	msaa_3d = anti_aliasing as MSAA

```

**game_timer.gd**
```gdscript
extends Node

var play_time : int
var total_time : int

func _add_timers() -> void:
	var play_timer := Timer.new()
	play_timer.one_shot = false
	play_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	play_timer.timeout.connect(func() : play_time += 1)
	add_child(play_timer)
	play_timer.start(1)
	var total_timer := Timer.new()
	total_timer.one_shot = false
	total_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	total_timer.timeout.connect(func() : total_time += 1)
	add_child(total_timer)
	total_timer.start(1)

func _enter_tree() -> void:
	_add_timers()

func _exit_tree() -> void:
	var game_state := GameState.get_or_create_state()
	game_state.play_time += play_time
	game_state.total_time += total_time
	GlobalState.save()

```

##### game_world

###### entities

####### allied_projectile

**bullet.gd**
```gdscript
extends Area2D

@export var speed: float
@export var damage: int

@onready var bullet_particle = preload("res://scenes/game_scene/game_world/entities/allied_projectile/bullet_particle.tscn")

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body):
	# Check if the body is the enemy's body
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		var bullet_effect = bullet_particle.instantiate()
		get_tree().root.add_child(bullet_effect)
		bullet_effect.setup(global_transform)
		queue_free() # Destroy the bullet on impact

func _on_lifespan_timeout() -> void:
	queue_free() # Deletes the bullet when time runs out

```

**bullet_particle.gd**
```gdscript
extends Node2D

@onready var bullet_effect: GPUParticles2D = $BulletEffect

func setup(trans: Transform2D):
	bullet_effect.emitting = true
	transform = trans
	scale.x = -1

func _on_bullet_effect_finished():
	queue_free()

```

####### enemies

**base_enemy.gd**
```gdscript
extends CharacterBody2D

@export var speed: float
@export var max_health: int
@export var health: int
@export var damage: int

@onready var player = Global.player_node
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var polygon_2d: Polygon2D = $Polygon2D


func _physics_process(_delta):
	# Calculate direction from enemy to player
	var direction: Vector2 = global_position.direction_to(player.global_position)
		
	# Set velocity and move
	velocity = direction * speed
	move_and_slide()

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	# 1. Disable collisions to stop further interactions
	polygon_2d.hide()
	collision_shape.set_deferred("disabled", true)
	speed = 0
	
	# 2. Play the death animation
	animated_sprite_2d.play("death")
	
	# 3. Wait for the animation to finish before deleting the node
	await animated_sprite_2d.animation_finished
	queue_free()

```

####### player

**camera2d.gd**
```gdscript
extends Camera2D

@export var zoom_speed: float
@export var min_zoom: float
@export var max_zoom: float

var target_zoom: Vector2 = Vector2(1.0, 1.0)

func _ready() -> void:
	target_zoom = zoom

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				target_zoom += Vector2(zoom_speed, zoom_speed)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				target_zoom -= Vector2(zoom_speed, zoom_speed)
			
			# Clamp the zoom so it stays within reasonable limits
			target_zoom.x = clamp(target_zoom.x, min_zoom, max_zoom)
			target_zoom.y = clamp(target_zoom.y, min_zoom, max_zoom)

func _process(_delta: float) -> void:
	# Lerp (linear interpolation) creates a smooth zooming effect
	zoom = zoom.lerp(target_zoom, 0.1)

```

**player.gd**
```gdscript
extends CharacterBody2D
signal player_die

@export var speed: float
@export var rotation_speed: float
@export var backward_multiplier: float

@export var max_health: int
@export var health: int


func _ready():
	Global.player_node = self

var rotation_direction: float = 0.0
	
func get_input() -> void:
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	var throttle: float = Input.get_axis("move_backward", "move_forward")
	velocity = _get_drive_velocity(throttle)

func _get_drive_velocity(throttle: float) -> Vector2:
	if throttle < 0.0:
		throttle *= backward_multiplier
	return -throttle * speed * transform.y

func _physics_process(delta: float) -> void:
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die():
	await get_tree().create_timer(0.1).timeout
	player_die.emit()

```

**turret.gd**
```gdscript
extends Node2D

@export var Bullet: CustomizablePackedScene
@export var fire_cooldown: float

@onready var Muzzle: Marker2D = $Muzzle
@onready var turret_sprite: AnimatedSprite2D = $TurretSprite
@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound

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
	var bullet := Bullet.instantiate() as Area2D
	if bullet == null:
		return
	bullet.global_transform = Muzzle.global_transform
	var spawn_parent := get_tree().root
	spawn_parent.add_child(bullet)
	turret_sprite.play("shoot")
	shoot_sound.play()
	_cooldown_timer = fire_cooldown

```

####### the_base

**the_base.gd**
```gdscript
extends StaticBody2D
signal base_destroyed

@export var max_health: int
@export var health: int

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	Global.the_base_node = self

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	animated_sprite_2d.play("destroyed")
	await animated_sprite_2d.animation_finished
	queue_free()
	base_destroyed.emit()
	

```

**the_weapon.gd**
```gdscript
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

```

##### game_world

**main_objective.gd**
```gdscript
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

```

##### hud

**health_bar.gd**
```gdscript
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

```

**hud.gd**
```gdscript
extends CanvasLayer

func open_tutorials() -> void:
	$tutorial_manager.open_tutorials()

func _on_tutorial_button_pressed() -> void:
	open_tutorials()

```

**time_played.gd**
```gdscript
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

```

#### game_scene

**input_display_label.gd**
```gdscript
extends Label

@onready var action_names := AppSettings.get_action_names()

func _get_inputs_as_string() -> String:
	var all_inputs : String = ""
	var is_first : bool = true
	for action_name in action_names:
			if Input.is_action_pressed(action_name):
				if is_first:
					is_first = false
					all_inputs += action_name
				else:
					all_inputs += " + " + action_name
	return all_inputs

func _process(_delta : float) -> void:
	if Input.is_anything_pressed():
		text = _get_inputs_as_string()
	else:
		text = ""

```

**tutorial_manager.gd**
```gdscript
extends Node
## A script to add into a level or game scene to display tutorial windows.

## A list of tutorial scenes to open, one after the other.
@export var tutorial_scenes : Array[PackedScene]
## If true, open the tutorials when the scene becomes ready.
@export var auto_open : bool = false
## Delay before opening the tutorials when the scene becomes ready.
@export var auto_open_delay : float = 0.25

func open_tutorials() -> void:
	var _initial_focus_control : Control = get_viewport().gui_get_focus_owner()
	for tutorial_scene in tutorial_scenes:
		var tutorial_menu : Control = tutorial_scene.instantiate()
		if tutorial_menu == null:
			push_warning("tutorial failed to open %s" % tutorial_scene)
			return
		get_tree().current_scene.call_deferred("add_child", tutorial_menu)
		if tutorial_menu.has_signal(&"closed"):
			await tutorial_menu.closed
		else:
			await tutorial_menu.tree_exited
		if is_inside_tree() and _initial_focus_control:
			_initial_focus_control.grab_focus()

func _ready() -> void:
	if auto_open:
		if auto_open_delay > 0.0:
			await get_tree().create_timer(auto_open_delay, false).timeout
		open_tutorials.call_deferred()

```

#### loading_screen

**loading_screen.gd**
```gdscript
extends LoadingScreen

```

**loading_screen_with_shader_caching.gd**
```gdscript
extends LoadingScreen
## Loading Screen extension that pre-loads shaders before opening the next scene.

## Path to directory with the material shaders that should be pre-loaded.
@export_dir var _spatial_shader_material_dir : String
## Path to the scene that should trigger a shader pre-loading.
@export_file("*.tscn") var _cache_shaders_scene : String
## Mesh object that the material shaders should be applied to.
@export var _mesh : Mesh
@export_group("Advanced")
## Includes material scenes with extensions that match the strings.
@export var _matching_extensions : Array[String] = [".tres", ".material", ".res"]
## Excludes subfolders that match the strings.
@export var _ignore_subfolders : Array[String] = [".", ".."]
## Delay between loading each shader onto the mesh.
@export var _shader_delay_timer : float = 0.1

var _loading_shader_cache : bool = false

var _caching_progress : float = 0.0 :
	set(value):
		if value <= _caching_progress:
			return
		_caching_progress = value
		update_total_loading_progress()
		_reset_loading_stage()

func can_load_shader_cache() -> bool:
	return not _spatial_shader_material_dir.is_empty() and \
	not _cache_shaders_scene.is_empty() and \
	SceneLoader.is_loading_scene(_cache_shaders_scene)

func update_total_loading_progress() -> void:
	var partial_total := _scene_loading_progress
	if can_load_shader_cache():
		partial_total += _caching_progress
		partial_total /= 2
	_total_loading_progress = partial_total

func _set_scene_loading_complete() -> void:
	super._set_scene_loading_complete()
	if can_load_shader_cache() and not _loading_shader_cache:
		_loading_shader_cache = true
		_show_all_draw_passes_once()
	if can_load_shader_cache() and _caching_progress < 1.0:
		return
	SceneLoader._background_loading = false
	SceneLoader.set_process(true)

func _show_all_draw_passes_once() -> void:
	var all_materials := _traverse_folders(_spatial_shader_material_dir)
	var total_material_count := all_materials.size()
	var cached_material_count := 0
	for material_path in all_materials:
		_load_material(material_path)
		cached_material_count += 1
		_caching_progress = float(cached_material_count) / total_material_count
		if _shader_delay_timer > 0:
			await(get_tree().create_timer(_shader_delay_timer).timeout)

func _traverse_folders(dir_path:String) -> PackedStringArray:
	var material_list:PackedStringArray = []
	if not dir_path.ends_with("/"):
		dir_path += "/"
	var dir := DirAccess.open(dir_path)
	if not dir:
		push_error("failed to access the path ", dir_path)
		return []
	if dir.list_dir_begin() != OK:
		push_error("failed to access the path ", dir_path)
		return []
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir():
			var matches : bool = false
			for extension in _matching_extensions:
				if file_name.ends_with(extension):
					matches = true
					break
			if matches:
				material_list.append(dir_path + file_name)
		else:
			var subfolder_name := file_name
			if not subfolder_name in _ignore_subfolders:
				material_list.append_array(_traverse_folders(dir_path + subfolder_name))
		file_name = dir.get_next()
	
	return material_list

func _load_material(path:String) -> void:
	var material_shower := MeshInstance3D.new()
	material_shower.mesh = _mesh
	var material := ResourceLoader.load(path) as Material
	material_shower.set_surface_override_material(0, material)
	%SpatialShaderTypeCaches.add_child(material_shower)

func _ready() -> void:
	SceneLoader._background_loading = true

```

#### menus

##### level_select_menu

**level_select_menu.gd**
```gdscript
extends Control

## Loads a simple ItemList node within a margin container. SceneLister updates
## the available scenes in the directory provided. Activating a level will update
## the GameState's current_level, and emit a signal. The main menu node will trigger
## a load action from that signal.

signal level_selected

@onready var level_buttons_container: ItemList = %LevelButtonsContainer
@onready var scene_lister: SceneLister = $SceneLister
var level_paths : Array[String]

func _ready() -> void:
	add_levels_to_container()
	
## A fresh level list is propgated into the ItemList, and the file names are cleaned
func add_levels_to_container() -> void:
	level_buttons_container.clear()
	level_paths.clear()
	var game_state := GameState.get_or_create_state()
	for file_path in game_state.level_states.keys():
		var file_name : String = file_path.get_file()  # e.g., "level_1.tscn"
		file_name = file_name.trim_suffix(".tscn")  # Remove the ".tscn" extension
		file_name = file_name.replace("_", " ")  # Replace underscores with spaces
		file_name = file_name.capitalize()  # Convert to proper case
		var button_name := str(file_name)
		level_buttons_container.add_item(button_name)
		level_paths.append(file_path)

func _on_level_buttons_container_item_activated(index: int) -> void:
	GameState.set_checkpoint_level_path(level_paths[index])
	level_selected.emit()

```

##### main_menu

**main_menu.gd**
```gdscript
extends MainMenu
## Main menu extension that adds options.
## The scene adds a 'Continue' button if a game is in progress.

## Optional scene to open when the player clicks a 'Level Select' button.
@export var level_select_packed_scene: PackedScene
## If true, have the player confirm before starting a new game if a game is in progress.
@export var confirm_new_game : bool = true

@onready var continue_game_button = %ContinueGameButton
@onready var level_select_button = %LevelSelectButton
@onready var new_game_confirmation = %NewGameConfirmation

func load_game_scene() -> void:
	GameState.start_game()
	super.load_game_scene()

func new_game() -> void:
	if confirm_new_game and continue_game_button.visible:
		new_game_confirmation.show()
	else:
		GameState.reset()
		load_game_scene()

func _add_level_select_if_set() -> void: 
	if level_select_packed_scene == null: return
	if GameState.get_levels_reached() <= 1 : return
	level_select_button.show()

func _show_continue_if_set() -> void:
	if GameState.get_current_level_path().is_empty(): return
	continue_game_button.show()

func _ready() -> void:
	super._ready()
	_add_level_select_if_set()
	_show_continue_if_set()

func _on_continue_game_button_pressed() -> void:
	GameState.continue_game()
	load_game_scene()

func _on_level_select_button_pressed() -> void:
	var level_select_scene := _open_sub_menu(level_select_packed_scene)
	if level_select_scene.has_signal("level_selected"):
		level_select_scene.connect("level_selected", load_game_scene)

func _on_new_game_confirmation_confirmed() -> void:
	GameState.reset()
	load_game_scene()

```

**main_menu_with_animations.gd**
```gdscript
extends MainMenu
## Main menu extension that adds options and animates the title and menu fading in.
## The scene adds a 'Continue' button if a game is in progress.
## The animation can be skipped by the player with any input.

## Optional scene to open when the player clicks a 'Level Select' button.
@export var level_select_packed_scene: PackedScene
## If true, have the player confirm before starting a new game if a game is in progress.
@export var confirm_new_game : bool = true

var animation_state_machine : AnimationNodeStateMachinePlayback

@onready var continue_game_button = %ContinueGameButton
@onready var level_select_button = %LevelSelectButton
@onready var new_game_confirmation = %NewGameConfirmation

func load_game_scene() -> void:
	GameState.start_game()
	super.load_game_scene()

func new_game() -> void:
	if confirm_new_game and continue_game_button.visible:
		new_game_confirmation.show()
	else:
		GameState.reset()
		load_game_scene()

func intro_done() -> void:
	animation_state_machine.travel("OpenMainMenu")

func _is_in_intro() -> bool:
	return animation_state_machine.get_current_node() == "Intro"

func _event_skips_intro(event : InputEvent) -> bool:
	return event.is_action_released("ui_accept") or \
		event.is_action_released("ui_select") or \
		event.is_action_released("ui_cancel") or \
		_event_is_mouse_button_released(event)

func _open_sub_menu(menu : PackedScene) -> Node:
	animation_state_machine.travel("OpenSubMenu")
	return super._open_sub_menu(menu)

func _close_sub_menu() -> void:
	super._close_sub_menu()
	animation_state_machine.travel("OpenMainMenu")

func _input(event : InputEvent) -> void:
	if _is_in_intro() and _event_skips_intro(event):
		intro_done()
		return
	super._input(event)

func _show_level_select_if_set() -> void: 
	if level_select_packed_scene == null: return
	if GameState.get_levels_reached() <= 1 : return
	level_select_button.show()

func _show_continue_if_set() -> void:
	if GameState.get_current_level_path().is_empty(): return
	continue_game_button.show()

func _ready() -> void:
	super._ready()
	_show_level_select_if_set()
	_show_continue_if_set()
	animation_state_machine = $MenuAnimationTree.get("parameters/playback")

func _on_continue_game_button_pressed() -> void:
	GameState.continue_game()
	load_game_scene()

func _on_level_select_button_pressed() -> void:
	var level_select_scene := _open_sub_menu(level_select_packed_scene)
	if level_select_scene.has_signal("level_selected"):
		level_select_scene.connect("level_selected", load_game_scene)

func _on_new_game_confirmation_confirmed() -> void:
	GameState.reset()
	load_game_scene()

```

##### options_menu

###### audio

**audio_input_option_control.gd**
```gdscript
@tool
extends ListOptionControl

func _set_input_device() -> void:
	var current_setting : Variant = _get_setting(default_value)
	if current_setting is bool:
		current_setting = &"Default"
	AudioServer.input_device = _get_setting(default_value)

func _add_microphone_audio_stream() -> void:
	var instance := AudioStreamPlayer.new()
	instance.stream = AudioStreamMicrophone.new()
	instance.autoplay = true
	add_child.call_deferred(instance)
	instance.ready.connect(_set_input_device)

func _ready() -> void:
	if ProjectSettings.get_setting("audio/driver/enable_input", false):
		show()
		if AudioServer.input_device.is_empty():
			_add_microphone_audio_stream()
		else:
			_set_input_device()
		if not Engine.is_editor_hint():
			option_values = AudioServer.get_input_device_list()
	else:
		hide()
	super._ready()

func _on_setting_changed(value : Variant) -> void:
	if value >= option_values.size(): return
	AudioServer.input_device = option_values[value]
	super._on_setting_changed(value)

func _value_title_map(value : Variant) -> String:
	if value is String:
		return value
	else:
		return super._value_title_map(value)

```

###### game

**game_options_menu.gd**
```gdscript
extends Control

func _on_ResetGameControl_reset_confirmed() -> void:
	GameState.reset()

```

####### reset_game_control

**reset_game_control.gd**
```gdscript
extends HBoxContainer

const RESET_STRING := "Reset Game:"
const CONFIRM_STRING := "Confirm Reset:"

signal reset_confirmed

func _on_cancel_button_pressed():
	%CancelButton.hide()
	%ConfirmButton.hide()
	%ResetButton.show()
	%ResetButton.grab_focus()
	%ResetLabel.text = RESET_STRING

func _on_reset_button_pressed():
	%CancelButton.show()
	%ConfirmButton.show()
	%CancelButton.grab_focus()
	%ResetButton.hide()
	%ResetLabel.text = CONFIRM_STRING

func _on_confirm_button_pressed():
	reset_confirmed.emit()
	get_tree().paused = false
	SceneLoader.reload_current_scene()

```

##### options_menu

**mini_options_menu_with_reset.gd**
```gdscript
extends "res://addons/maaacks_game_template/base/nodes/menus/options_menu/mini_options_menu.gd"

func _on_reset_game_control_reset_confirmed() -> void:
	GameState.reset()

```

#### windows

**game_lost_window.gd**
```gdscript
@tool
extends OverlaidWindow

@export_file("*.tscn") var main_menu_scene_path : String

func _ready():
	if OS.has_feature("web"):
		%ExitButton.hide()

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path

func _load_scene(scene_path: String) -> void:
	_scene_tree.paused = false
	SceneLoader.load_scene(scene_path)

func _on_exit_button_pressed():
	%ExitConfirmation.show()

func _on_main_menu_button_pressed():
	%MainMenuConfirmation.show()

func _on_close_button_pressed():
	SceneLoader.reload_current_scene()
	close()

func _on_main_menu_confirmation_confirmed():
	_load_scene(get_main_menu_scene_path())

func _on_exit_confirmation_confirmed():
	get_tree().quit()

```

**game_won_window.gd**
```gdscript
@tool
extends OverlaidWindow

signal continue_pressed
signal main_menu_pressed

@export_file("*.tscn") var ending_scene_path : String

func get_ending_scene_path() -> String:
	if ending_scene_path.is_empty():
		return AppConfig.ending_scene_path
	return ending_scene_path

func _load_scene(scene_path: String) -> void:
	_scene_tree.paused = false
	SceneLoader.load_scene(scene_path)

func _ready():
	if OS.has_feature("web"):
		%ExitButton.hide()

func _on_exit_button_pressed():
	%ExitConfirmation.show()

func _on_main_menu_button_pressed():
	%MainMenuConfirmation.show()

func _on_close_button_pressed():
	continue_pressed.emit()
	close()
	_load_scene(get_ending_scene_path())

func _on_main_menu_confirmation_confirmed():
	main_menu_pressed.emit()
	close()

func _on_exit_confirmation_confirmed():
	get_tree().quit()

```

**level_won_window.gd**
```gdscript
extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

```

**main_menu_credits_window.gd**
```gdscript
@tool
extends "res://addons/maaacks_game_template/base/nodes/windows/overlaid_window_scene_container.gd"

func _ready() -> void:
	super._ready()
	if instance and instance.has_signal(&"end_reached"):
		instance.connect(&"end_reached", close)

```

**pause_menu.gd**
```gdscript
@tool
extends OverlaidWindow

@export var options_menu_scene : PackedScene
## Path to a main menu scene.
## Will attempt to read from AppConfig if left empty.
@export_file("*.tscn") var main_menu_scene_path : String
@export_node_path(&"ConfirmationOverlaidWindow") var restart_confirmation_node_path : NodePath
@export_node_path(&"ConfirmationOverlaidWindow") var main_menu_confirmation_node_path : NodePath
@export_node_path(&"ConfirmationOverlaidWindow") var exit_confirmation_node_path : NodePath
@export var menu_container_node_path : NodePath = ^".."

@onready var restart_confirmation : ConfirmationOverlaidWindow = get_node(restart_confirmation_node_path)
@onready var main_menu_confirmation : ConfirmationOverlaidWindow = get_node(main_menu_confirmation_node_path)
@onready var exit_confirmation : ConfirmationOverlaidWindow = get_node(exit_confirmation_node_path)
@onready var menu_container : Node = get_node(menu_container_node_path)
@onready var options_button = %OptionsButton
@onready var main_menu_button = %MainMenuButton
@onready var exit_button = %ExitButton

var open_window : Node
var _ignore_first_cancel : bool = false

func get_main_menu_scene_path() -> String:
	if main_menu_scene_path.is_empty():
		return AppConfig.main_menu_scene_path
	return main_menu_scene_path

func close_window() -> void:
	if open_window != null:
		if open_window.has_method("close"):
			open_window.close()
		else:
			open_window.hide()
		open_window = null

func _disable_focus() -> void:
	for child in %MenuButtons.get_children():
		if child is Control:
			child.focus_mode = FOCUS_NONE

func _enable_focus() -> void:
	for child in %MenuButtons.get_children():
		if child is Control:
			child.focus_mode = FOCUS_ALL

func _load_scene(scene_path: String) -> void:
	_scene_tree.paused = false
	SceneLoader.load_scene(scene_path)

func _show_window(window : Control) -> void:
	_disable_focus.call_deferred()
	window.show()
	open_window = window
	await window.hidden
	open_window = null
	_enable_focus.call_deferred()

func _load_and_show_menu(scene : PackedScene) -> void:
	var window_instance : Control = scene.instantiate()
	window_instance.visible = false
	menu_container.add_child.call_deferred(window_instance)
	await _show_window(window_instance)
	window_instance.queue_free()

func _handle_cancel_input() -> void:
	if _ignore_first_cancel:
		_ignore_first_cancel = false
		return
	if open_window != null:
		close_window()
	else:
		super._handle_cancel_input()

func show() -> void:
	super.show()
	if Input.is_action_pressed("ui_cancel"):
		_ignore_first_cancel = true

func _refresh_exit_button() -> void:
	exit_button.visible = !OS.has_feature("web")

func _refresh_options_button() -> void:
	options_button.visible = options_menu_scene != null

func _refresh_main_menu_button() -> void:
	main_menu_button.visible = !get_main_menu_scene_path().is_empty()

func _ready() -> void:
	_refresh_exit_button()
	_refresh_options_button()
	_refresh_main_menu_button()
	restart_confirmation.confirmed.connect(_on_restart_confirmation_confirmed)
	main_menu_confirmation.confirmed.connect(_on_main_menu_confirmation_confirmed)
	exit_confirmation.confirmed.connect(_on_exit_confirmation_confirmed)

func _on_restart_button_pressed() -> void:
	_show_window(restart_confirmation)

func _on_options_button_pressed() -> void:
	_load_and_show_menu(options_menu_scene)

func _on_main_menu_button_pressed() -> void:
	_show_window(main_menu_confirmation)

func _on_exit_button_pressed() -> void:
	_show_window(exit_confirmation)

func _on_restart_confirmation_confirmed() -> void:
	SceneLoader.reload_current_scene()
	close()

func _on_main_menu_confirmation_confirmed():
	_load_scene(get_main_menu_scene_path())

func _on_exit_confirmation_confirmed():
	get_tree().quit()

```

**pause_menu_layer.gd**
```gdscript
extends CanvasLayer

@onready var pause_menu = %PauseMenu

func _on_pause_menu_hidden():
	hide()

func _on_visibility_changed():
	if visible:
		pause_menu.show()

func _ready():
	visibility_changed.connect(_on_visibility_changed)

```

### scripts

**game_state.gd**
```gdscript
class_name GameState
extends Resource

const STATE_NAME : String = "GameState"
const FILE_PATH = "res://scripts/game_state.gd"

@export var level_states : Dictionary = {}
@export var current_level_path : String
@export var checkpoint_level_path : String
@export var total_games_played : int
@export var play_time : int
@export var total_time : int

static func get_level_state(level_state_key : String) -> LevelState:
	if not has_game_state(): 
		return
	var game_state := get_or_create_state()
	if level_state_key.is_empty() : return
	if level_state_key in game_state.level_states:
		return game_state.level_states[level_state_key] 
	else:
		var new_level_state := LevelState.new()
		game_state.level_states[level_state_key] = new_level_state
		GlobalState.save()
		return new_level_state

static func has_game_state() -> bool:
	return GlobalState.has_state(STATE_NAME)

static func get_or_create_state() -> GameState:
	return GlobalState.get_or_create_state(STATE_NAME, FILE_PATH)

static func get_current_level_path() -> String:
	if not has_game_state(): 
		return ""
	var game_state := get_or_create_state()
	return game_state.current_level_path

static func get_checkpoint_level_path() -> String:
	if not has_game_state(): 
		return ""
	var game_state := get_or_create_state()
	return game_state.checkpoint_level_path

static func get_levels_reached() -> int:
	if not has_game_state(): 
		return 0
	var game_state := get_or_create_state()
	return game_state.level_states.size()

static func set_checkpoint_level_path(level_path : String) -> void:
	var game_state := get_or_create_state()
	game_state.checkpoint_level_path = level_path
	get_level_state(level_path)
	GlobalState.save()

static func set_current_level_path(level_path : String) -> void:
	var game_state := get_or_create_state()
	game_state.current_level_path = level_path
	GlobalState.save()

static func start_game() -> void:
	var game_state := get_or_create_state()
	game_state.total_games_played += 1
	GlobalState.save()

static func continue_game() -> void:
	var game_state := get_or_create_state()
	game_state.current_level_path = game_state.checkpoint_level_path
	GlobalState.save()

static func reset() -> void:
	var game_state := get_or_create_state()
	game_state.level_states = {}
	game_state.current_level_path = ""
	game_state.checkpoint_level_path = ""
	game_state.play_time = 0
	game_state.total_time = 0
	GlobalState.save()

```

**level_and_state_manager.gd**
```gdscript
extends LevelManager

func set_current_level_path(value : String) -> void:
	super.set_current_level_path(value)
	GameState.set_current_level_path(value)

func set_checkpoint_level_path(value : String) -> void:
	super.set_checkpoint_level_path(value)
	GameState.set_checkpoint_level_path(value)

func get_checkpoint_level_path() -> String:
	var state_level_path := GameState.get_checkpoint_level_path()
	if not state_level_path.is_empty():
		return state_level_path
	return super.get_checkpoint_level_path()

```

**level_state.gd**
```gdscript
class_name LevelState
extends Resource

@export var color : Color
@export var tutorial_read : bool = false

```

