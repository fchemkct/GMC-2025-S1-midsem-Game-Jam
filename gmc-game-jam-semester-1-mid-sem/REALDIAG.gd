extends Control

##@export var lines: Array[String] = ["hello",]
@export var dialogue_gdscript : GDScript = null 	##this is where we drag the script
var dlines = null

var current_line = 0
var choice_on = false
var spell_on = false


func _ready():
	dlines = dialogue_gdscript.new()
	$choices.hide()
	if get_node_or_null("$choice2"):
		$choice2.hide()
	if get_node_or_null("$SpellCast"):
		$SpellCast.hide()
	show()
	display_next_line()

func display_next_line():
	if (current_line < dlines.lines.size()):
		if (!dlines.lines[current_line].contains("#")):
			$Textlabel.text = dlines.lines[current_line]
			current_line += 1
			print("no # found, normal text")
		elif dlines.lines[current_line].contains("#speaker"):
			var end = dlines.lines[current_line].find("#")
			var speaker = end + 9
			$"Node2D/Name panel/label text".text = dlines.lines[current_line].substr(speaker)
			$Textlabel.text = dlines.lines[current_line].substr(0,end)
			current_line += 1
			print("speaker #")
		elif dlines.lines[current_line].contains("#choices"):
			print("# parsed through")
			choice_on = true
			$choices.show()
			current_line += 1
		elif dlines.lines[current_line].contains("#choice2"):
			print("# 2 parsed through")
			choice_on = true
			$choice2.show()
			current_line += 1
	
		elif dlines.lines[current_line].contains("#spellcasts"):
			print("# da whimsical spell casturrrgh")
			await get_tree().create_timer(0.5).timeout 
			spell_on = true
			$SpellCast.show()
			##$spellcast1.set_process(true)
			##get_tree().change_scene_to_file("res://spellcast_1.tscn")
			##$choices.show()
			##current_line += 1
	else:
		_dialogueEnd()
		##emit_signal("dialogue_finished")  # Optional: use this to trigger spellcast, etc.
		##get_tree().change_scene_to_file("res://spellcast_1.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept") && !choice_on && !spell_on:  # Press Enter/Space/etc
		display_next_line()
		
func _dialogueEnd():
	hide()

	
