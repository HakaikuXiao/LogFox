extends Node


func _ready() -> void:
	# Enable file logging
	if not ProjectSettings.get_setting("debug/file_logging/enable_file_logging"):
		error("File logging is not enabled", self)
		ProjectSettings.set_setting("debug/file_logging/enable_file_logging", true)
		info("File logging is enabled by plugin(to one run)", self)
		warning("Please enable this manually in project settings to work properly", self)

	info("_ready", self)


func _exit_tree() -> void:
	info("_exit_tree", self)


func info(message: String, source: Node) -> void:
	_log(message, "[color=#A6E3A1]INFO[/color]", source)


func warning(message: String, source: Node) -> void:
	_log(message, "[color=#F9E2AF]WARNING[/color]", source)
	push_warning("[" + source.name + "] " + message)


func error(message: String, source: Node) -> void:
	_log(message, "[color=#F38BA8]ERROR[/color]", source)
	push_error("[" + source.name + "] " + message)
	breakpoint


func _log(message: String, log_level: String, source: Node) -> void:
	print_rich(
		"[",
		Time.get_time_string_from_system(),
		"] ",
		"(",
		source.get_name(),
		") ",
		"[",
		log_level,
		"] ",
		message
	)
