extends CharacterBody2D
class_name Spiky

var dir:Vector2 = Vector2.UP
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	dir = dir.rotated(2*PI*randf())
	#apply_central_force(dir*250)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = dir * speed
	var collided = move_and_slide()
	if(collided):
		dir = dir.rotated(2*PI*randf())
		var collider = get_last_slide_collision().get_collider()
		if(collider is Node and collider.name == "PlayerHeart"):
			collider.body_entered.emit(self)

