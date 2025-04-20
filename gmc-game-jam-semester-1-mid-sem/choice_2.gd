extends Button
@onready var dialogue = $"../.."

@export var new_lines: Array[String] = [
	"choice clicked",
	"uhuhuihu",
	"f",
]

func _ready():
	var button = Button.new()
	button.text = "choice 2"
	button.pressed.connect(_on_pressed)
	add_child(button)

func _on_pressed() -> void:
	dialogue.lines = new_lines
	dialogue.current_line = 0
	print("choice pressed")
	dialogue.choice_on = false
	dialogue.display_next_line()
	$"..".hide()
	 # Replace with function body.
