extends Microgame

var seconds_to_finish = 5
var endsize = 5
var kiss_get = false
var path = null
@onready var kiss = %Kiss 

# Called when the node enters the scene tree for the first time.
func _microgame_ready():
	var paths = $Paths.get_children()
	var choose_path = randi_range(0, paths.size()-1)

	path = paths[choose_path].get_child(0)
	path.rotates = false
	kiss.reparent(path)
	kiss.position = Vector2.ZERO
	path.progress_ratio = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!kiss_get):
		path.progress_ratio = clamp(path.progress_ratio+delta*(1.0/seconds_to_finish),0,1)
		var kiss_size = 1 + (endsize*path.progress_ratio)
		kiss.scale = Vector2(kiss_size ,kiss_size)
		


func _on_hand_collision_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area == kiss):
		kiss_get = true
		$PepeCharacter.player_control = false
		%PepeSprite.play("catch")
		$BreCharacter.play("win")
		kiss.queue_free()
		finished.emit(true)
