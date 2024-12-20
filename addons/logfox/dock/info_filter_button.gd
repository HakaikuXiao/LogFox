@tool
extends Button


func _ready() -> void:
	toggled.connect(_on_toggled)


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$"../WarnButton".button_pressed = false
		$"../ErrorButton".button_pressed = false
		%FileTextLabel.parse_lines(%FileButtons.current_file, 0)
	else:
		%FileTextLabel.parse_lines(%FileButtons.current_file, 3)
