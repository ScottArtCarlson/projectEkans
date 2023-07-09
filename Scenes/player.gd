extends CharacterBody2D

# gets the screen size for wrapping
@onready var screen_size = get_viewport_rect().size

#gets the animation tree as a variable
@onready var animation_tree = $AnimationTree
# get the animation tree controler ready, this is the little crosshair on the animation blend space
@onready var state_machine = animation_tree.get("parameters/playback")
# set the player back to the top left corner after death
@onready var respawn_position = global_position

# sets up a new signal that we will emit later, when the player is hit by a snake
signal player_killed

# players speed, export so that it is editable in the menu
@export var SPEED = 150.0
# starting position 
@export var starting_position : Vector2 = Vector2(0, 1)
# i_frame makes the layer imprtal for 200 frames after a hit so that they can get away from the segment spawn
var i_frame = 200

func _ready():
	# sets the starting position of the animation
	update_animation_parameters(starting_position)

# gets the input from both arrow keys and wasd
func handleInput():
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * SPEED
	
	# sends the input direction to the animation blend space
	update_animation_parameters(input_direction)
	
	# handles actions but doesnt do anything yet
	var action = Input.is_action_just_pressed("action")
	if action:
		handleAction()
		
	var pause = Input.is_action_just_pressed("pause")
	

# main physics loop, handles input, movement, and wrapping. delta is underscored if it is not used, oterwise an error is thrown
func _physics_process(_delta):
	handleInput()
	velocity = velocity.normalized() * SPEED
	move_and_slide()
	# checks each frame if it needs to change to the next animation
	pick_new_state()
#	screen_wrap()
	if i_frame > 0:
		i_frame -= 1

# no use yet
func handleAction():
	$BellAudioPlayer.play()
	print("action pressed")
	
# wraps player back to opposite side
func screen_wrap():
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y
		
# using the move_input as a vector pointing in some direction, set the animation tree to the correct animation
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Bike/blend_position", move_input)

# I think this does the same thing as the update animation parameters fuction, but im not sure
func pick_new_state():
	if velocity != Vector2.ZERO:
		# the travel command is how you switch between nodes on the animation tree
		state_machine.travel("Bike")
	else:
		state_machine.travel("Idle")
		# needed the stop in here to stop the animation from looping after it reached an idle command
		state_machine.stop()

func _on_hurt_box_area_entered(area):
	
	global_position = starting_position
	if i_frame > 0:
		return
	else:
		i_frame = 200
		player_killed.emit()
