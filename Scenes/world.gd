extends Node2D

# get the canvas loaded into memory
@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# using the new global Event script, connects the level_complete signal from snake segment to a function, show_level_complete
	Events.level_completed.connect(show_level_completed)
	
	get_tree().paused = true
	
	animation_player.play("Count Down")
	await animation_player.animation_finished
	get_tree().paused = false	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# reveals the hidden canvas layer
func show_level_completed():
	level_completed.show()
	# pauses the game
	get_tree().paused = true

# custom signal from the player scene
func _on_player_player_killed():

	# Preps a new snake_segment
	var newSegment = load("res://Scenes/snake_segment.tscn")
	# instanciates it nad loads it into a temp var
	var temp = newSegment.instantiate()
	# saves the snake container in a temp varaible
	var tempLocation = $SnakeContainer
	# adds the new segment to the tree via add_child
	tempLocation.add_child(temp)
	print("new segment")
