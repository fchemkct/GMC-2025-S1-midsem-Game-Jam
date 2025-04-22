extends Control
		   
@onready var dialogue
@onready var SpellCast
@export var dialogue_gdscript : GDScript = null  ##this is where we drag the script
var clines = null

func _ready():
	dialogue = $"../../.." ##add normal after /root/ later
	SpellCast = $"../.." ##get_parent().get_node("/root/normal/tavern/Control/DialogueBox")
	clines = dialogue_gdscript.new()
	SpellCast.hide()
	#SpellCast.set_process_input(true)
	

func ReturnToDialogue() -> void:
	dialogue.dlines = clines
	dialogue.current_line = 0
	print("return to dialogue  pressed")
	##dialogue.spell_on = false
	NpcTalkOrder.spellOn = false
	dialogue.display_next_line()
	SpellCast.hide()
	#SpellCast.set_process_input(false) 
	 # Replace with function body.
