@tool
class_name FlattenForLLMDock
extends PanelContainer

const CONFIG_FILE_PATH = "res://.godot/flatten_for_llm_config.ini"

@onready var output_path_edit: LineEdit = $ScrollContainer/MarginContainer/VBoxContainer/OutputContainer/OutputPathEdit
@onready var browse_button: Button = $ScrollContainer/MarginContainer/VBoxContainer/OutputContainer/BrowseButton
@onready var radio_exclude: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/FilterModeContainer/RadioExclude
@onready var radio_include: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/FilterModeContainer/RadioInclude
@onready var folders_edit: LineEdit = $ScrollContainer/MarginContainer/VBoxContainer/FoldersContainer/FoldersEdit
@onready var check_gd: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/TogglesContainer/CheckGD
@onready var check_tscn: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/TogglesContainer/CheckTSCN
@onready var check_tres: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/TogglesContainer/CheckTRES
@onready var check_gdshader: CheckBox = $ScrollContainer/MarginContainer/VBoxContainer/TogglesContainer/CheckGDShader
@onready var generate_button: Button = $ScrollContainer/MarginContainer/VBoxContainer/GenerateButton
@onready var status_label: Label = $ScrollContainer/MarginContainer/VBoxContainer/StatusLabel
@onready var open_folder_button: Button = $ScrollContainer/MarginContainer/VBoxContainer/OpenFolderButton
@onready var file_dialog: FileDialog = $FileDialog

func _ready() -> void:
	var filter_group: ButtonGroup = ButtonGroup.new()
	radio_exclude.button_group = filter_group
	radio_include.button_group = filter_group

	browse_button.pressed.connect(_on_browse_button_pressed)
	generate_button.pressed.connect(_on_generate_button_pressed)
	open_folder_button.pressed.connect(_on_open_folder_button_pressed)
	file_dialog.dir_selected.connect(_on_file_dialog_dir_selected)

	_load_config()

func _on_browse_button_pressed() -> void:
	file_dialog.popup_centered()

func _on_generate_button_pressed() -> void:
	_save_config()
	var output_dir: String = output_path_edit.text
	if output_dir.is_empty() or not DirAccess.dir_exists_absolute(output_dir):
		status_label.text = "Status: Error - Invalid output directory."
		return

	var folders: PackedStringArray = folders_edit.text.split(",", false)
	for i in range(folders.size()):
		folders[i] = folders[i].strip_edges()

	var is_include: bool = radio_include.button_pressed

	if check_gd.button_pressed:
		_generate_for_extension(".gd", output_dir, folders, is_include)
	if check_tscn.button_pressed:
		_generate_for_extension(".tscn", output_dir, folders, is_include)
	if check_tres.button_pressed:
		_generate_for_extension(".tres", output_dir, folders, is_include)
	if check_gdshader.button_pressed:
		_generate_for_extension(".gdshader", output_dir, folders, is_include)

	status_label.text = "Status: Context generated successfully!"

	if Engine.is_editor_hint():
		EditorInterface.get_resource_filesystem().scan()

func _on_open_folder_button_pressed() -> void:
	var dir_to_open: String = output_path_edit.text
	if dir_to_open.is_empty():
		dir_to_open = "res://"
	OS.shell_open(ProjectSettings.globalize_path(dir_to_open))

func _on_file_dialog_dir_selected(dir: String) -> void:
	output_path_edit.text = dir
	_save_config()

func _load_config() -> void:
	var config: ConfigFile = ConfigFile.new()
	if config.load(CONFIG_FILE_PATH) == OK:
		output_path_edit.text = config.get_value("settings", "output_path", "res://")
		folders_edit.text = config.get_value("settings", "folders", "addons, .godot")

		var is_include: bool = config.get_value("settings", "is_include", false)
		radio_include.button_pressed = is_include
		radio_exclude.button_pressed = not is_include

		check_gd.button_pressed = config.get_value("settings", "check_gd", true)
		check_tscn.button_pressed = config.get_value("settings", "check_tscn", false)
		check_tres.button_pressed = config.get_value("settings", "check_tres", false)
		check_gdshader.button_pressed = config.get_value("settings", "check_gdshader", false)
	else:
		output_path_edit.text = "res://"

func _save_config() -> void:
	var config: ConfigFile = ConfigFile.new()
	config.set_value("settings", "output_path", output_path_edit.text)
	config.set_value("settings", "folders", folders_edit.text)
	config.set_value("settings", "is_include", radio_include.button_pressed)
	config.set_value("settings", "check_gd", check_gd.button_pressed)
	config.set_value("settings", "check_tscn", check_tscn.button_pressed)
	config.set_value("settings", "check_tres", check_tres.button_pressed)
	config.set_value("settings", "check_gdshader", check_gdshader.button_pressed)
	config.save(CONFIG_FILE_PATH)

func _generate_for_extension(ext: String, out_dir: String, folders: PackedStringArray, is_include: bool) -> void:
	var game_title: String = ProjectSettings.get_setting("application/config/name", "Godot Project")
	var markdown_content: String = "# [" + game_title + "] Project Context File: " + ext + "\n\n"

	var all_files: PackedStringArray = []

	if is_include:
		if folders.is_empty():
			_collect_files("res://", ext, [], all_files)
		else:
			for folder in folders:
				var start_path: String = "res://" + folder.trim_prefix("res://").trim_prefix("/")
				if not start_path.ends_with("/"):
					start_path += "/"
				_collect_files(start_path, ext, [], all_files)
	else:
		_collect_files("res://", ext, folders, all_files)

	var file_array: Array = Array(all_files)
	file_array.sort()

	var current_dir_segments: PackedStringArray = []

	for file_path in file_array:
		var dir_path: String = file_path.get_base_dir()
		var dir_segments: PackedStringArray = ["res://"]
		if dir_path != "res://":
			dir_segments.append_array(dir_path.replace("res://", "").split("/", false))

		var divergence_index: int = 0
		while divergence_index < current_dir_segments.size() and divergence_index < dir_segments.size():
			if current_dir_segments[divergence_index] == dir_segments[divergence_index]:
				divergence_index += 1
			else:
				break

		var print_from: int = divergence_index
		if print_from == dir_segments.size() and current_dir_segments != dir_segments:
			print_from = dir_segments.size() - 1

		for i in range(print_from, dir_segments.size()):
			var depth: int = i + 2
			var heading: String = ""
			for j in range(depth):
				heading += "#"
			heading += " " + dir_segments[i] + "\n\n"
			markdown_content += heading

		current_dir_segments = dir_segments

		var file_name: String = file_path.get_file()
		markdown_content += _format_file_content(file_path, file_name, ext)

	var ext_name: String = ext.replace(".", "")
	var out_file_path: String = out_dir + "/project_context_" + ext_name + ".md"
	var file: FileAccess = FileAccess.open(out_file_path, FileAccess.WRITE)
	if file:
		file.store_string(markdown_content)
		file.close()

func _collect_files(path: String, ext: String, excludes: PackedStringArray, file_list: PackedStringArray) -> void:
	var dir: DirAccess = DirAccess.open(path)
	if not dir:
		return

	dir.list_dir_begin()
	var file_name: String = dir.get_next()

	while file_name != "":
		if file_name == "." or file_name == "..":
			file_name = dir.get_next()
			continue

		var full_path: String = path + file_name
		var relative_path: String = full_path.trim_prefix("res://")

		if dir.current_is_dir():
			var is_excluded: bool = false
			for exclude in excludes:
				var clean_exclude: String = exclude.trim_prefix("res://").trim_suffix("/")
				# Matches exact folder name anywhere OR the specific relative path tree
				if file_name == clean_exclude or relative_path == clean_exclude or relative_path.begins_with(clean_exclude + "/"):
					is_excluded = true
					break
			if not is_excluded:
				_collect_files(full_path + "/", ext, excludes, file_list)
		else:
			if file_name.ends_with(ext):
				file_list.append(full_path)

		file_name = dir.get_next()

	dir.list_dir_end()

func _format_file_content(full_path: String, file_name: String, ext: String) -> String:
	var file: FileAccess = FileAccess.open(full_path, FileAccess.READ)
	if not file:
		return ""

	var content: String = file.get_as_text()
	file.close()

	var syntax: String = ""
	if ext == ".gd":
		syntax = "gdscript"
	elif ext == ".gdshader":
		syntax = "glsl"
	elif ext == ".tscn" or ext == ".tres":
		syntax = "ini"

	return "**" + file_name + "**\n```" + syntax + "\n" + content + "\n```\n\n"
