@tool
extends EditorPlugin

const FLATTEN_FOR_LLM_DOCK = preload("res://addons/flatten_for_llm/flatten_for_llm_dock.tscn")

var dock_instance: Control

func _enter_tree() -> void:
	dock_instance = FLATTEN_FOR_LLM_DOCK.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR,dock_instance)

func _exit_tree() -> void:
	if dock_instance:
		remove_control_from_docks(dock_instance)
		dock_instance.queue_free()
