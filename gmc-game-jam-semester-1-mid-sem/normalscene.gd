extends Node2D
@onready var minimap = preload("res://minimap.tscn").instantiate()

func _ready():
	add_child(minimap)  # Add the minimap to your scene
	minimap.visible = false

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_M:
		minimap.visible = !minimap.visible  # Toggle map with M
