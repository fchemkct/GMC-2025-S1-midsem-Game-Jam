extends Node2D



func _on_spellcast_4_hidden() -> void:
	$spellcast5.spell5 = true
	$spellcast5.show() # Replace with function body.
	print("signal activated")
