extends CharacterBody2D

# Set the player as the target, this is why the snake head has to be different
@onready var target = $"../../Player"

#gets the animation tree as a variable
@onready var animation_tree = $AnimationTree
# get the animation tree controler ready, this is the little crosshair on the animation blend space
@onready var state_machine = animation_tree.get("parameters/playback")

# Snake speed
@export var SPEED = 100.0
# unused currently
@export var startingNodes = 3
# starting direction for animation
@export var starting_position : Vector2 = Vector2(0, 1)

func _ready():
	update_animation_parameters(starting_position)
	state_machine.travel("Drive_Head")

func _physics_process(_delta):
	if target != null:
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()
		
		update_animation_parameters(velocity)
	
	# checks each frame if it needs to change to the next animation
	state_machine.travel("Drive_Head")
	# nothing yet
#	addSnakeSegment()

# no function yet, I want it to add a new snake segment to the snake container when pressed/when ate
func addSnakeSegment():
	if Input.is_action_just_pressed("action"):
		pass

# using the move_input as a vector pointing in some direction, set the animation tree to the correct animation
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Drive_Head/blend_position", move_input)

func _on_snake_hurt_box_area_entered(area):
	pass
#	print("Hurt - self collision")
