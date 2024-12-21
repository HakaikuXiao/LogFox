@tool
extends Label


func _ready():
	name = "Coordinate"
	anchor_right = 1
	anchor_left = 1
	offset_right = -20
	grow_horizontal = Control.GROW_DIRECTION_BEGIN
	add_theme_color_override("font_color", Color.hex(0x94E2D5ff))
	text = "(0.0, 0.0)"
