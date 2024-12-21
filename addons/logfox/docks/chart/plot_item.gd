class_name PlotItem
extends RefCounted

var label: String:
	set(value):
		label = value
		if not label.is_empty():
			_curve.name = label
	get:
		return label

var color: Color = Color.hex(0x94E2D5ff):
	set(value):
		color = value
		_curve.color = color

var thickness: float = 1.0:
	set(value):
		if value > 0.0:
			thickness = value
			_curve.width = thickness

var line_curve = preload("res://addons/logfox/docks/chart/plot_2d.gd")
var _curve
var _points: PackedVector2Array
var _graph


func _init(obj, l, c, w):
	_curve = line_curve.new()
	_graph = obj
	label = l
	_curve.name = l
	_curve.color = c
	_curve.width = w
	_graph.get_node("PlotArea").add_child(_curve)


func add_point(pt: Vector2):
	_points.append(pt)
	var point = pt.clamp(Vector2(_graph.x_min, _graph.y_min), Vector2(_graph.x_max, _graph.y_max))
	var pt_px: Vector2
	pt_px.x = remap(point.x, _graph.x_min, _graph.x_max, 0, _graph.get_node("PlotArea").size.x)
	pt_px.y = remap(point.y, _graph.y_min, _graph.y_max, _graph.get_node("PlotArea").size.y, 0)
	_curve.points_px.append(pt_px)
	_curve.queue_redraw()


func remove_point(pt: Vector2):
	if _points.find(pt) == -1:
		printerr("No point found with the coordinates of %s" % str(pt))
	_points.remove_at(_points.find(pt))
	var point = pt.clamp(Vector2(_graph.x_min, _graph.y_min), Vector2(_graph.x_max, _graph.y_max))
	var pt_px: Vector2
	pt_px.x = remap(point.x, _graph.x_min, _graph.x_max, 0, _graph.get_node("PlotArea").size.x)
	pt_px.y = remap(point.y, _graph.y_min, _graph.y_max, _graph.get_node("PlotArea").size.y, 0)
	_curve.points_px.remove_at(_curve.points_px.find(pt_px))
	_curve.queue_redraw()


func remove_all():
	_points.clear()
	_curve.points_px.clear()
	_curve.queue_redraw()


func delete():
	_graph.get_node("PlotArea").remove_child(_curve)
	_curve.queue_free()
	call_deferred("unreference")


func _redraw():
	_curve.points_px.clear()
	for pt in _points:
		if pt.x > _graph.x_max or pt.x < _graph.x_min:
			continue
		var point = pt.clamp(
			Vector2(_graph.x_min, _graph.y_min), Vector2(_graph.x_max, _graph.y_max)
		)
		var pt_px: Vector2
		pt_px.x = remap(point.x, _graph.x_min, _graph.x_max, 0, _graph.get_node("PlotArea").size.x)
		pt_px.y = remap(point.y, _graph.y_min, _graph.y_max, _graph.get_node("PlotArea").size.y, 0)
		_curve.points_px.append(pt_px)
	_curve.queue_redraw()
