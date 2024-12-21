@tool
extends VBoxContainer

var current_line: float = 0.0
var chart: Graph2D


func _ready() -> void:
	chart = $"../../../RightContainer/Graph2D"
	reset_props_tab()


func reset_props_tab() -> void:
	for child in get_children():
		child.queue_free()

	for file in DirAccess.open(OS.get_user_data_dir()).get_files():
		if not file.ends_with(".prop"):
			continue
		var file_path: String = OS.get_user_data_dir() + "/" + file
		var file_name: String = file.replace(".prop", "")
		add_file_button(file_name, file_path)


func add_file_button(file_name: String, file_path: String) -> void:
	var file_button: Button = Button.new()
	file_button.alignment = 0
	file_button.text = file_name
	file_button.connect("pressed", Callable(self, "_create_chart").bind(file_path))
	add_child(file_button)


func _create_chart(file_path: String) -> void:
	chart.x_min = 0.0
	chart.x_max = (FileAccess.open(file_path, FileAccess.READ).get_as_text().split("\n").size()) - 1.0
	chart.y_min = find_min_value_in_file(file_path)
	chart.y_max = find_max_value_in_file(file_path)
	var plot := chart.add_plot_item()
	var line_count: float

	if not FileAccess.file_exists(file_path):
		reset_props_tab()
		return
	var file: PackedStringArray = FileAccess.open(file_path, FileAccess.READ).get_as_text().split(
		"\n"
	)
	for line in file:
		if line_count > 50.0:
			return
		if not line.is_valid_float():
			print("'" + line + "'" + " line isn't a float/int value")
			return
		plot.add_point(Vector2(line_count, float(line)))
		line_count += 1.0


func find_min_value_in_file(file_path: String) -> float:
	var min_value: float = INF
	var file: PackedStringArray = FileAccess.open(file_path, FileAccess.READ).get_as_text().split(
		"\n"
	)
	for line in file:
		if line.is_valid_float():
			if float(line) < min_value:
				min_value = float(line)
	return min_value


func find_max_value_in_file(file_path: String) -> float:
	var max_value: float = -INF
	var file: PackedStringArray = FileAccess.open(file_path, FileAccess.READ).get_as_text().split(
		"\n"
	)
	for line in file:
		if line.is_valid_float():
			if float(line) > max_value:
				max_value = float(line)
	return max_value
