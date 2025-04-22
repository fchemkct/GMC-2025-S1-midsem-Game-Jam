extends Node2D

@export var original_path: Array[Vector2] = []  # Reference path to match against
var drawn_points: Array[Vector2] = []
var is_drawing := false
var mouse_pos: Vector2 = Vector2.ZERO
var guide_progress := 0.0

var tries := 0
const MAX_TRIES := 2
var success := false

func _ready():
	var path_node = $sptrace8  # Adjust the path as needed
	var curve = path_node.curve
	for i in range(curve.get_point_count()):
		original_path.append(curve.get_point_position(i) * 1) #MULTIPLY THE SCALE FACTOR OF THE PATH
	set_process(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_drawing = event.pressed
			if is_drawing:
				drawn_points.clear()
				drawn_points.append(get_local_mouse_position())
				
	elif event is InputEventMouseMotion:
		mouse_pos = get_local_mouse_position()  # <-- Track mouse always
		if is_drawing:
			drawn_points.append(mouse_pos)
		queue_redraw() 
	"""
	elif event is InputEventMouseMotion and is_drawing:
		drawn_points.append(get_global_mouse_position())
		queue_redraw()
	"""
	
func _process(delta):
	# Animate the ghost guide along the original path
	if original_path.size() >= 2:
		guide_progress += delta * 0.8  # adjust speed 
		if guide_progress > 1.0:
			guide_progress = 0.0
		queue_redraw()



func _draw():
	
	if drawn_points.size() >= 2:
		for i in range(1, drawn_points.size()):
			draw_line(drawn_points[i - 1], drawn_points[i], Color.RED, 2)
	
	if original_path.size() >= 2:
		var point_count = original_path.size()
		var index = int(guide_progress * (point_count - 1))
		var next_index = min(index + 1, point_count - 1)
		var t = (guide_progress * (point_count - 1)) - index
		var pos = original_path[index].lerp(original_path[next_index], t)

		# Draw the animated guidance circle
		draw_circle(pos, 13, Color(1, 1, 1, 1))  # white guide
 

	draw_circle(mouse_pos, 8, Color(0, 0.6, 1, 0.4))  # Light blue guide circle
	draw_circle(mouse_pos, 3, Color(0, 0.6, 1, 1))     # Inner dot for clarity


# Call this to compare paths
func compare_trace_to_original():
	if paths_match(original_path, drawn_points):
		print("✅ Traced accurately!")
		success = true
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

		
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		if NpcTalkOrder.spellOn:
			if success:
				return  # Already succeeded
			if tries >= MAX_TRIES:
				print("❌ You've used all attempts!") #JUST DELETE THIS 
				return

			tries += 1
			compare_trace_to_original()

		if tries >= MAX_TRIES and not success:
			print("❌ Game over. No more tries.") 
			#ADD IN THE DIALOGUES AND MOVE ON
