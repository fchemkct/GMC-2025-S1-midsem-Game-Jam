extends Control

@onready var dialogue
@onready var SpellCast
@export var dialogue_gdscript : GDScript = null  ##this is where we drag the script
var clines = null

func _ready():
	dialogue = get_parent().get_node("/root/DialogueBox") ##add normal after /root/ later
	SpellCast = get_parent().get_node("/root/DialogueBox/SpellCast")
	clines = dialogue_gdscript.new()
	SpellCast.hide()
	

func ReturnToDialogue() -> void:
	dialogue.dlines = clines
	dialogue.current_line = 0
	print("return to dialogue  pressed")
	dialogue.spell_on = false
	dialogue.display_next_line()
	SpellCast.hide()
	 # Replace with function body.
