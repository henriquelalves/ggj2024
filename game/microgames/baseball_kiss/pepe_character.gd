extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_control = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(player_control):
		var direction = Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			%PepeSprite.animation = "walk"
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			%PepeSprite.animation = "default"

		move_and_slide()
