extends Control

@export var lines: Array[String] = [
	"Welcome to the world of Godot.",
	"This is a simple dialogue box.",
	"Now go forth, and cast some spells!",
	"#choices",
	"abc", 
	"e",
]

var current_line = 0
var choice_on = false
func _ready():
	$choices.hide()
	
	show()
	display_next_line()

func display_next_line():
	if (current_line < lines.size()) && (!lines[current_line].contains("#")):
		$Textlabel.text = lines[current_line]
		current_line += 1
	elif (current_line < lines.size()) && lines[current_line].contains("#choices"):
		print("# parsed through")
		choice_on = true
		$choices.show()
		
		current_line += 1
	else:
		hide()
		emit_signal("dialogue_finished")  # Optional: use this to trigger spellcast, etc.

func _input(event):
	if event.is_action_pressed("ui_accept") && !choice_on:  # Press Enter/Space/etc
		display_next_line()
