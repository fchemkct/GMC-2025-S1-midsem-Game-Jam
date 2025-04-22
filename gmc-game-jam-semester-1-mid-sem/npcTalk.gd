extends CharacterBody2D

@onready var dialogue = $Control/DialogueBox
var isTalk = false
@onready var id = $NameTag.text

func _ready() -> void:
	NpcTalkOrder.canTalk = "Sadal"

func  _input(event):
	if event.is_action_pressed("dialogue") && NpcTalkOrder.inRange && NpcTalkOrder.canTalk == id:
		print("sadal")
		_talk()

func _talk():
	dialogue.display_next_line()
	

	
