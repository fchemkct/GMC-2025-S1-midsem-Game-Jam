extends Node2D

@export var original_path: Array[Vector2] = []  # Reference path to match against
var drawn_points: Array[Vector2] = []
var is_drawing := false

func _ready():
	var path_node = $Path2D  # Adjust the path as needed
	var curve = path_node.curve
	for i in range(curve.get_point_count()):
		original_path.append(path_node.to_global(curve.get_point_position(i)))


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_drawing = event.pressed
			if is_drawing:
				drawn_points.clear()
				drawn_points.append(get_global_mouse_position())
	elif event is InputEventMouseMotion and is_drawing:
		drawn_points.append(get_global_mouse_position())
		queue_redraw()

func _draw():
	if drawn_points.size() >= 2:
		for i in range(1, drawn_points.size()):
			draw_line(drawn_points[i - 1], drawn_points[i], Color.RED, 2)

	# Optional: draw original path for reference (in green)
	if original_path.size() >= 2:
		for i in range(1, original_path.size()):
			draw_line(original_path[i - 1], original_path[i], Color.GREEN, 1)

# Call this to compare paths
func compare_trace_to_original():
	if paths_match(original_path, drawn_points):
		print("✅ Traced accurately!")
	else:
		print("❌ Try again, not close enough.")

# Core matching logic
func paths_match(original: Array[Vector2], drawn: Array[Vector2], tolerance := 20.0) -> bool:
	if drawn.size() < original.size() * 0.5:
		return false  # Not enough points drawn

	var match_count = 0
	var step = float(original.size()) / drawn.size()

	for i in range(drawn.size()):
		var index := int(i * step)
		if index >= original.size():
			break
		var dist := drawn[i].distance_to(original[index])
		if dist <= tolerance:
			match_count += 1

	var match_ratio = float(match_count) / original.size()
	return match_ratio > 0.8  # 80% match required

# Trigger comparison when SPACE is pressed
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		compare_trace_to_original()
