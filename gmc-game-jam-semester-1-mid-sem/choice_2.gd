extends Button
@onready var dialogue = $"../.."

@export var dialogue_gdscript : GDScript = null 	##this is where we drag the script
var clines = null

func _ready():
	clines = dialogue_gdscript.new()
	$"..".hide()
	var button = Button.new()
	button.text = $"label text".text
	button.pressed.connect(_on_pressed)
	add_child(button)

func _on_pressed() -> void:
	dialogue.dlines = clines
	dialogue.current_line = 0
	print("choice pressed")
	dialogue.choice_on = false
	dialogue.display_next_line()
	$"..".hide()
	 # Replace with function body.
