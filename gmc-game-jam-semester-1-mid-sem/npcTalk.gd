extends CharacterBody2D

@onready var dialogue = $Node2D/Control/CanvasLayer/DialogueBox
@onready var id = $NameTag.text
@onready var textbox = get_node("$../../Node2D/Control")

func  _input(event):
	if event.is_action_pressed("dialogue") && NpcTalkOrder.dialogueTrue() && NpcTalkOrder.canTalk == id:
		print("npc yapped once")
		NpcTalkOrder.isTalking = true
		_talk()
	if event.is_action_pressed("dialogue") && NpcTalkOrder.isTalking && NpcTalkOrder.canTalk == id:
		print("npc is now yapping")
		_talk()

func _talk():
	print("talked")
	$"Node2D/Control/CanvasLayer".show()
	dialogue.display_next_line()
	

	
