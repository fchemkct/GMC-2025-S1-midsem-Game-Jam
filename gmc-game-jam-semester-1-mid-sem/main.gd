extends Node

"""
@onready var fade_rect = $FadeLayer/FadeRect
@onready var tween = create_tween()

func fade_and_switch_scene(scene_path: String):
	# Fade to black
	tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)  # Fade alpha to 1 over 1 second
	await tween.finished

	# Now switch scene
	get_tree().change_scene_to_file(scene_path)
	
	
##ADD THIS TO THE END OF THE DIALOGUE NOT HERE !!!!!!!
fade_and_switch_scene("res://scenes/YourNextScene.tscn")
	
"""
