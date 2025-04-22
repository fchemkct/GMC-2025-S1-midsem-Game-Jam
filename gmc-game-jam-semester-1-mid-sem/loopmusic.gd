extends Node

func _ready():
	var audio = load("res://31 BIDØ - Infinite 24 Bit MASTER.mp3") as AudioStream
	audio.loop = true  # Set loop flag in code
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.play()
