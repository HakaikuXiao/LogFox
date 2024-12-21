extends Node


func _ready() -> void:
	# Enable file logging
	if not ProjectSettings.get_setting("debug/file_logging/enable_file_logging"):
		error("File logging is not enabled", self)
		ProjectSettings.set_setting("debug/file_logging/enable_file_logging", true)
		info("File logging is enabled by plugin(to one run)", self)
		warning("Please enable this manually in project settings to work properly", self)

	_clear_property_logs()
	info("Cleared .prop files", self)
	info("_ready", self)


func _exit_tree() -> void:
	info("_exit_tree", self)


## Log information message
func info(message: String, source: Node) -> void:
	_log(message, "[color=#A6E3A1]INFO[/color]", source)


## Log warning message and push it to debugger
func warning(message: String, source: Node) -> void:
	_log(message, "[color=#F9E2AF]WARNING[/color]", source)
	push_warning("[" + source.name + "] " + message)


## Log error message, push it to debugger and create breakpoint
func error(message: String, source: Node) -> void:
	_log(message, "[color=#F38BA8]ERROR[/color]", source)
	push_error("[" + source.name + "] " + message)
	breakpoint


## Func to log property values to see graphic of it.
func log_property(source: Node, property: String) -> void:
	var file: FileAccess
	if source.get(property) == null:
		LogFox.error("Property to log is null", source)
		return

	if FileAccess.file_exists("user://" + property + ".prop"):
		file = FileAccess.open("user://" + property + ".prop", FileAccess.READ_WRITE)
	else:
		file = FileAccess.open("user://" + property + ".prop", FileAccess.WRITE)

	if (
		(
			FileAccess
			. open("user://" + property + ".prop", FileAccess.READ)
			. get_as_text()
			. split("\n")
			. size()
		)
		> 50.0
	):
		LogFox.info("End of file reached to log property", source)
		return

	file.seek_end()
	file.store_line(str(source.get(property)))
	file.close()


# Internal func to clear property logs
func _clear_property_logs() -> void:
	var dir: DirAccess = DirAccess.open(OS.get_user_data_dir())
	for file in dir.get_files():
		if not file.ends_with(".prop"):
			continue
		dir.remove(file)


# Internal func to print messages
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
