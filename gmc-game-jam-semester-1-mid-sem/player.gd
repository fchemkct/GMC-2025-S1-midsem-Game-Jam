extends CharacterBody2D
signal inRange

var speed = 200
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
	
			
	##position  += velocity * delta
	# Use move_and_slide() to handle physics-based movement and collisions
	var collision = move_and_collide(velocity * delta)
	##position = position.clamp(Vector2.ZERO, screenSize)
	
	if collision:
		NpcTalkOrder.inRange = true
		print("enter:cantalk bool is: " + str(NpcTalkOrder.inRange))
	else:
		await get_tree().create_timer(2).timeout 
		NpcTalkOrder.inRange = false
		print("exit:cantalk bool is: " + str(NpcTalkOrder.inRange))
	
