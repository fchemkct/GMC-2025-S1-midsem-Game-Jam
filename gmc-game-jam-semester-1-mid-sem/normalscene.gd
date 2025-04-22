extends Node2D

@onready var minimap = preload("res://minimap.tscn").instantiate()

@onready var dialogue_list := [
	$doctor/DialogueBox,
	$mailman/DialogueBox,
	$tavern/DialogueBox,
	$botanist/DialogueBox
]

var current_index := 0
var current_box : Node = null  # Reference to the current visible dialogue box

func _ready():
	# Add and hide the minimap
	add_child(minimap)
	minimap.visible = false

	# Hide all dialogue boxes initially
	for box in dialogue_list:
		box.visible = false

	# Start the dialogue sequence
	start_next_dialogue()

func _unhandled_input(event):
	# Only allow input to be processed by the current dialogue box
	if current_box and event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		current_box.display_next_line()  # Make sure you have this function to go to the next dialogue
		# Or trigger next dialogue depending on your DialogueBox setup

	if event is InputEventKey and event.pressed and event.keycode == KEY_M:
		minimap.visible = !minimap.visible  # Toggle map with M

func start_next_dialogue():
	if current_index >= dialogue_list.size():
		print("✅ All dialogues shown.")
		return

	# Hide all other dialogue boxes
	for box in dialogue_list:
		box.visible = false
	
	# Show the current dialogue box
	current_box = dialogue_list[current_index]
	current_box.visible = true
	current_box.start_dialogue()  # This function must be defined in your DialogueBox script
	current_box.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))

func _on_dialogue_finished():
	var current_box = dialogue_list[current_index]
	current_box.disconnect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
	current_box.visible = false
	current_index += 1
	start_next_dialogue()
