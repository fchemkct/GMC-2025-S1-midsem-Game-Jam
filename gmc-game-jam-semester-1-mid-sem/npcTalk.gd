extends CharacterBody2D

@onready var dialogue = $Control/DialogueBox
var isTalk = false
@onready var id = $NameTag.text

func  _input(event):
	if event.is_action_pressed("dialogue") && NpcTalkOrder.dialogueTrue() && NpcTalkOrder.canTalk == id:
		print("npc is yapping")
		_talk()

func _talk():
	print("talked")
	$Control.show()
	dialogue.display_next_line()
	

	
