extends Control

var uwu: float

func _process(_delta: float) -> void:
	randomize()
	uwu = randf_range(1, 10)
	LogFox.log_property(self, "uwu")
	
