extends CharacterBody2D

var player_in_range = false

func _on_TalkArea_body_entered(body):
	if body.name == "Player":  # Make sure to match your player node name
		player_in_range = true

func _on_TalkArea_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if player_in_range:  # You'd set this with Area2D like before
			show_dialogue()
			
func show_dialogue():
	var dialogue_label = get_node("res://demos/9. characters dialogue/characters_dialogue.tscn")
	dialogue_label.text = "Hi! I'm the NPC you just clicked!"
	dialogue_label.get_parent().visible = true
