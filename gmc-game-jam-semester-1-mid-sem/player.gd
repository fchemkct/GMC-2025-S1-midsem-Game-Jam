extends CharacterBody2D
signal inRange

var speed = 800
var screenSize
var canTalk = false; ##determines if player is in range to talk to another npc
##@onready var dialogue = $"../CharactersDialogue"

##@onready var dialogue_label = get_node("res://demos/9. characters dialogue/characters_dialogue.tscn")
func _ready():
	screenSize = get_viewport_rect().size
	
func _process(delta: float):
	walk(delta)
	
	##dialogue.show()
	#pass

	
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

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	elif velocity.y != 0:
		##$AnimatedSprite2D.animation = "front"
		if velocity.y >= 0:
			$AnimatedSprite2D.animation = "front"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "back"
	
			
	position += velocity * delta
	# Use move_and_slide() to handle physics-based movement and collisions
	velocity = move_and_slide()
	##position = position.clamp(Vector2.ZERO, screenSize)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	##hide()
	##inRange.emit()
	canTalk = true
	
	print("enter:cantalk bool is: " + str(canTalk))



func _on_area_2d_body_exited(body: Node2D) -> void:
	canTalk = false
	print("exit:cantalk bool is: " + str(canTalk))
	 # Replace with function body.
 # Replace with function body.
