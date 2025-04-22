extends Node2D
@export var original_pic: Sprite2D

# Stores all the points for drawing
var points = []

# Boolean to track if the user is currently drawing
var drawing = false


# Handles input events (mouse or touch)
func _input(event):
	if event is InputEventMouseButton:
		# Check if left mouse button is pressed or released
		if event.button_index == MOUSE_BUTTON_LEFT:
			drawing = event.pressed
			if drawing:
				# Start a new stroke by adding the first point
				points.append([event.position])
	elif event is InputEventMouseMotion and drawing:
		# Add the mouse position to the latest stroke while drawing
		points[-1].append(event.position)
		queue_redraw()  # Trigger the _draw() function

# Draws the polyline based on the stored points
func _draw():
	for stroke in points:
		if stroke.size() > 1:
			# Draw lines connecting each point in the stroke
			draw_polyline(stroke, Color(0, 0, 0), 3.0)  # Black color, line thickness 3

# Save the drawing as a PNG file
func save_drawing():
	# Get the current viewport's image (the screen content)
	var img = get_viewport().get_texture().get_image()
	
	# Save the image to the user data directory (you can change the path)
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
			return texture.get_data()  # Get the image data from the sprite's texture
	return null

# Compare the player's drawing with the original image
func compare_trace_to_original():
	# Get the current drawing as an image (from viewport)
	var trace_image = get_viewport().get_texture().get_image()
	
	# Capture the original image from the sprite
	var original_image = get_original_image()
	if not original_image:
		print("Original image not found.")
		return

	# Make sure both images are the same size before comparing
	if trace_image.get_width() != original_image.get_width() or trace_image.get_height() != original_image.get_height():
		print("Images are different sizes, comparison not possible.")
		return
	
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
