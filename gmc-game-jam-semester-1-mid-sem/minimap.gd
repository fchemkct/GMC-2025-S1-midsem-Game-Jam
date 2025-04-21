extends CanvasLayer


@onready var texture_rect = $TextureRect
@onready var viewport = $MinimapViewport
@onready var camera = $MinimapViewport/MinimapCamera
@onready var player = get_node("/root/node_2dNORMAL/Player")  # Adjust path based on your game root

func _ready():
	# Ensure the minimap's texture uses the viewport (with transparency enabled)
	texture_rect.texture = viewport.get_texture()
	texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
	texture_rect.size = Vector2(200, 200)  # Set minimap size (adjust as needed)
	texture_rect.position = Vector2(20, 20)  # Position on screen
	self.visible = false  # Start hidden

	# Make the minimap semi-transparent (adjust the alpha value to control transparency)
	texture_rect.modulate = Color(1, 1, 1, 0.5)  # 0.5 = 50% transparent, change as needed

func _process(delta):
	# Follow the player with the minimap camera
	camera.global_position = player.global_position
