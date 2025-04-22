extends CharacterBody2D

@onready var dialogue = $Control/DialogueBox
@onready var id = $NameTag.text

func _ready() -> void:
	NpcTalkOrder.canTalk = id
	_talk()

func _talk():
	print("talked")
	$Control.show()
	dialogue.display_next_line()
	

	
