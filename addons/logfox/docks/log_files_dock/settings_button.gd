@tool
extends Button

var settings_window: Window


func _ready() -> void:
	pressed.connect(_open_settings)


func _open_settings() -> void:
	settings_window = preload("res://addons/logfox/settings/settings_window.tscn").instantiate()
	settings_window.connect("close_requested", _close_settings)
	EditorInterface.get_editor_main_screen().add_child(settings_window)


func _close_settings() -> void:
	settings_window.queue_free()
