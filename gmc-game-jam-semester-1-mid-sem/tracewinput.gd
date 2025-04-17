extends Node2D
@export var original_pic: Sprite2D

var last_mouse_pos : Vector2
var is_drawing = false

# Store the drawn path for continuous lines
var drawn_points : Array = []

func _ready():
	last_mouse_pos = Vector2.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		if is_drawing:
			var mouse_pos = to_local(event.position)  # Get local mouse position
			drawn_points.append(mouse_pos)  # Track the mouse path
			queue_redraw() # Trigger _draw() to redraw

	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_drawing = true
				last_mouse_pos = to_local(event.position)
				drawn_points.clear()  # Clear previous points when a new drawing starts
				drawn_points.append(last_mouse_pos)  # Start the first point
			else:
				is_drawing = false  # Stop drawing when released

func _draw():
	if is_drawing:
		# Draw lines between points in the drawn path
		for i in range(1, drawn_points.size()):
			draw_line(drawn_points[i - 1], drawn_points[i], Color(1, 0, 0), 2)

# Save the drawing as a PNG file
func save_drawing():
	var img = get_viewport().get_texture().get_image()  # Capture the current image from the viewport
	var file_path = "user://drawing.png"
	var result = img.save_png(file_path)
	if result == OK:
		print("Drawing saved to: ", file_path)
	else:
		print("Failed to save drawing.")

# Capture the original drawing from the sprite's texture
func get_original_image() -> Image:
	if original_pic:
		var texture = original_pic.texture
		if texture:
			return texture.get_image()
	return null

# Compare the player's drawing with the original image
func compare_trace_to_original():
	var trace_image = get_viewport().get_texture().get_image()  # Get the current trace image from the viewport
	var original_image = get_original_image()

	if not original_image:
		print("Original image not found.")
		return

	# Resize original image to match the traced image if needed
	if original_image.get_size() != trace_image.get_size():
		print("Resizing original image to match trace image...")
		original_image.resize(trace_image.get_width(), trace_image.get_height(), Image.INTERPOLATE_NEAREST)

	# Compare each pixel of the images
	var is_match = true
	for x in range(trace_image.get_width()):
		for y in range(trace_image.get_height()):
			if trace_image.get_pixel(x, y) != original_image.get_pixel(x, y):
				is_match = false
				break
		if not is_match:
			break

	if is_match:
		print("The drawing matches the original!")
	else:
		print("The drawing does not match the original.")

# Capture input for comparing the drawing when pressing spacebar
func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			compare_trace_to_original()
