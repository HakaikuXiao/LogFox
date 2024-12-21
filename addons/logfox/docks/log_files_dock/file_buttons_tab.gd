@tool
extends VBoxContainer

var file_text_node: RichTextLabel
var current_file: String


func _ready() -> void:
	file_text_node = %FileTextLabel
	reset_files_tab()


func reset_files_tab() -> void:
	# Clear curr buttons
	for child in get_children():
		child.queue_free()

	# Create new buttons
	for file in DirAccess.open(OS.get_user_data_dir() + "/logs").get_files():
		if not file.ends_with(".log"):
			continue
		var file_path: String = OS.get_user_data_dir() + "/logs/" + file
		var file_name: String = parse_name(file)
		add_file_button(file_name, file_path)


func parse_name(file: String) -> String:
	var curr_date: String = str(Time.get_date_string_from_system())
	file = file.replace(".log", "")
	if file == "godot":
		return "LATEST"
	if file.contains(curr_date):
		return file.replace("godot" + curr_date + "T", "TODAY_")
	return file.replace("godot", "")


func add_file_button(file_name: String, file_path: String) -> void:
	var file_button: Button = Button.new()
	file_button.alignment = 0
	file_button.text = file_name
	file_button.connect("pressed", Callable(self, "_open_file").bind(file_path))
	add_child(file_button)


func _open_file(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		reset_files_tab()
		return
	current_file = file_path
	file_text_node.parse_lines(current_file, 3)
