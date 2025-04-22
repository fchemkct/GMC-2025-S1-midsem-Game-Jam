extends CharacterBody2D

@onready var dialogue = $Control/DialogueBox
@onready var id = $NameTag.text

func  _input(event):
	if event.is_action_pressed("dialogue") && NpcTalkOrder.dialogueTrue() && NpcTalkOrder.canTalk == id:
		print("npc yapped once")
		NpcTalkOrder.isTalking = true
		_talk()
	if event.is_action_pressed("dialogue") && NpcTalkOrder.isTalking:
		print("npc is now yapping")
		_talk()

func _talk():
	print("talked")
	$"../coffin/Control".show()
	dialogue.display_next_line()
	

	
