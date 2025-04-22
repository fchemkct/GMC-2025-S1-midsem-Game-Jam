extends Control

##@export var lines: Array[String] = ["hello",]
@export var dialogue_gdscript : GDScript = null 	##this is where we drag the script
var dlines = null

var current_line = 0

@onready var SpellCast = $SpellCast
func _ready():
	hide()
	await get_tree().create_timer(0.5).timeout 
	show()
	dlines = dialogue_gdscript.new()
	$choices.hide()
	if get_node_or_null("$choice2"):
		$choice2.hide()
	if get_node_or_null("$SpellCast"):
		var SpellCast = null
		$SpellCast.hide()
	
	##display_next_line()

func display_next_line():
	if (current_line < dlines.lines.size()):
		if (!dlines.lines[current_line].contains("#")):
			$Textlabel.text = dlines.lines[current_line]
			current_line += 1
			print(dlines.lines[current_line])
		elif dlines.lines[current_line].contains("#speaker"):
			var end = dlines.lines[current_line].find("#")
			var speaker = end + 9
			$"Node2D/Name panel/label text".text = dlines.lines[current_line].substr(speaker)
			$Textlabel.text = dlines.lines[current_line].substr(0,end)
			current_line += 1
			print(dlines.lines[current_line].substr(0,end))
		elif dlines.lines[current_line].contains("#choices"):
			print("# parsed through")
			##choice_on = true
			NpcTalkOrder.choiceOn = true
			$choices.show()
			current_line += 1
		elif dlines.lines[current_line].contains("#choice2"):
			print("# 2 parsed through")
			##choice_on = true
			NpcTalkOrder.choiceOn = true
			$choice2.show()
			current_line += 1
	
		elif dlines.lines[current_line].contains("#spellcasts"):
			print("# da whimsical spell casturrrgh")
			await get_tree().create_timer(0.5).timeout 
			##spell_on = true
			NpcTalkOrder.spellOn = true
			SpellCast.show()
			##$spellcast1.set_process(true)
			##get_tree().change_scene_to_file("res://spellcast_1.tscn")
			##$choices.show()
			##current_line += 1
		elif dlines.lines[current_line].contains("#end"):
			var hashtag = dlines.lines[current_line].find(":")
			var start = hashtag + 1
			NpcTalkOrder.canTalk = dlines.lines[current_line].substr(start)
			NpcTalkOrder.isTalking = false
			print(NpcTalkOrder.canTalk)
			_dialogueEnd()
			##current_line += 1
	else:
		_dialogueEnd()
		##emit_signal("dialogue_finished")  # Optional: use this to trigger spellcast, etc.
		 
		##get_tree().change_scene_to_file("res://spellcast_1.tscn")

#func _input(event):		##might merge this with npc's input
#	if event.is_action_pressed("ui_accept") :  # Press Enter/Space/etc
#		display_next_line()

		
func _dialogueEnd():
	hide()
	print("dialogue ended")
	
func start_dialogue():
	current_line = 0
	display_next_line()


	
