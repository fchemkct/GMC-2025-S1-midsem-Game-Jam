extends Node

var canTalk = null
var inRange = false
var choiceOn = false
var spellOn = false
var isTalking = false ##Used after player presses 'e'

func dialogueTrue() -> bool:
	if (inRange && !choiceOn && !spellOn && !isTalking):
		return true
	else:
		return false
