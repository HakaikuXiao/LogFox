@tool
extends EditorPlugin

var logfox_doc: Control


func _enter_tree() -> void:
	logfox_doc = preload("res://addons/logfox/dock/log_fox_dock.tscn").instantiate()
	add_control_to_bottom_panel(logfox_doc, "LogFox")
	add_autoload_singleton("LogFox", "res://addons/logfox/main.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("LogFox")
	remove_control_from_bottom_panel(logfox_doc)
