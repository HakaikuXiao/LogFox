@tool
extends RichTextLabel


func parse_lines(file_path: String, log_level: int = 0) -> void:
	text = ""
	if not FileAccess.file_exists(file_path):
		OS.alert("Open file before use filters!", "Warning")
		return
	for line in FileAccess.open(file_path, FileAccess.READ).get_as_text().split("\n"):
		var color: String = "[color=white]"
		match log_level:
			0:
				if not line.contains("INFO"):
					continue
				color = "[color=#A6E3A1]"
			1:
				if not line.contains("WARN"):
					continue
				color = "[color=#F9E2AF]"
			2:
				if not line.contains("ERROR"):
					continue
				color = "[color=#F38BA8]"
			3:
				if line.contains("INFO"):
					color = "[color=#A6E3A1]"
				elif line.contains("WARNING"):
					color = "[color=#F9E2AF]"
				elif line.contains("ERROR"):
					color = "[color=#F38BA8]"
		append_text(color + line + "\n")
