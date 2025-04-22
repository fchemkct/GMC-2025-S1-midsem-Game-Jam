extends Node

var canTalk = null
var inRange = false
var choiceOn = false
var spellOn = false

func dialogueTrue() -> bool:
	if (inRange && choiceOn && spellOn):
		return true
	else:
		return false
