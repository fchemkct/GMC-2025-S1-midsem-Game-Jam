extends Area2D
signal inRange

@export var speed = 400
var screenSize
var canTalk = false; ##determines if player is in range to talk to another npc
##@onready var dialogue = $"../CharactersDialogue"
func _ready():
	screenSize = get_viewport_rect().size
	
func _process(delta: float):
	walk(delta)
	##dialogue.show()
	pass
	
func walk(delta: float):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	##position = position.clamp(Vector2.ZERO, screenSize)


func _on_body_entered(body) -> void:
	##hide()
	##inRange.emit()
	canTalk = true
	
	print("enter:cantalk bool is: " + str(canTalk))
	 # Replace with function body.

func _on_body_exited(body) -> void:
	canTalk = false
	print("exit:cantalk bool is: " + str(canTalk))
	 # Replace with function body.
