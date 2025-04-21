extends Control

@onready var dialogue
@export var dialogue_gdscript : GDScript = null  ##this is where we drag the script
var clines = null

func _ready():
	dialogue = get_parent().get_node("/root/DialogueBox")
	clines = dialogue_gdscript.new()
	$"..".hide()
	

func ReturnToDialogue() -> void:
	dialogue.dlines = clines
	dialogue.current_line = 0
	print("return to dialogue  pressed")
	dialogue.spell_on = false
	dialogue.display_next_line()
	$"..".hide()
	 # Replace with function body.
