extends Node

"""
# Declare your nodes or groups
@onready var dialogue = $CharactersDialogue
@onready var player = $Player
@onready var spellcast = $spellcast1

func _ready():
	# Add nodes to groups
	dialogue.add_to_group("ui")
	player.add_to_group("ui")
	spellcast.add_to_group("spellcast")
	
	# Initially, hide everything but the dialogue and player
	set_group_visibility("ui", true)       # Show dialogue and player
	set_group_visibility("spellcast", false)  # Hide spellcast
	dialogue.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
 

# 🔔 This function is called when the dialogue is finished
func _on_dialogue_finished():
	show_spellcast()

# Function to set visibility of nodes in a group
func set_group_visibility(group_name: String, visible: bool):
	for node in get_tree().get_nodes_in_group(group_name):
		node.visible = visible

# Function to switch to the spellcast scene
func show_spellcast():
	set_group_visibility("ui", false)       # Hide dialogue and player
	set_group_visibility("spellcast", true)  # Show spellcast
	
"""
