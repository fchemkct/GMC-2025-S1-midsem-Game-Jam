extends Node

func _ready():
	var audio = load("res://audio/bgm.ogg") as AudioStream
	audio.loop = true  # Set loop flag in code
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.play()
