extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# custom signal from the player scene
#func _on_player_player_killed():
#
#	# we create a new timer that helps us to delay the snake segments spawning in too fast on top of us
#	var newSegment = load("res://Scenes/snake_segment.tscn")
#	var temp = newSegment.instantiate()
#	var tempLocation = $SnakeContainer
#	tempLocation.add_child(temp)
#	print("new segment")
#
#	await get_tree().create_timer(4.0).timeout
