extends RigidBody2D

var speed = 250
var playerControl = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(playerControl):
		var moveVector = Vector2(Input.get_axis("Left","Right")*speed, Input.get_axis("Up","Down")*speed)
		apply_force(moveVector)
	pass
