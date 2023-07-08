extends Node2D

@onready var level_completed = $CanvasLayer/LevelCompleted
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.level_completed.connect(show_level_completed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_level_completed():
	level_completed.show()
#	get_tree().paused = true

# custom signal from the player scene
func _on_player_player_killed():

	# we create a new timer that helps us to delay the snake segments spawning in too fast on top of us
	var newSegment = load("res://Scenes/snake_segment.tscn")
	var temp = newSegment.instantiate()
	var tempLocation = $SnakeContainer
	tempLocation.add_child(temp)
	print("new segment")
