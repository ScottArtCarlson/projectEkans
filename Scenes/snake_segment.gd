extends CharacterBody2D

# gets the current snake bit index, needs to be onready so that it counts after loading everything else
@onready var index = get_index()
# gets the target based on its own index - 1
@onready var target = get_parent().get_child(index-1)

#gets the animation tree as a variable
@onready var animation_tree = $AnimationTree
# get the animation tree controler ready, this is the little crosshair on the animation blend space
@onready var state_machine = animation_tree.get("parameters/playback")

# Snake movement speed, as export so that is can be edited in the editor
@export var SPEED = 300
# buffer between the snake bits so that they dint stack up, in pixels
@export var followOffset = 90
# starting direction for animation
@export var starting_position : Vector2 = Vector2(0, 1)

# counts the nuber of snake bits in the snake container
var getChildCount = 0
# I was hoping to get the traffic to slow down more naturally, but currently dows nothing
var deceleration = 15

# ready runs once when the scene is first instanciated
func _ready():
	# count the number of snake bits for later	
	if get_parent().get_child_count() == 1:
		pass
	else:
		getChildCount = get_parent().get_child_count()
	
	# gets the snimation state machine started
	update_animation_parameters(starting_position)
	# snake body only has one state, drive, so we set it to that at the start
	state_machine.travel("Drive")
	print("index added: ", index)

# physics process runs each frame, with delta being the time elapsed since the last frame
func _physics_process(_delta):
	# this check may be unnecessary, idk
	if target != null:		
		# finds the global position of the snake bit it is targeting at
		var target_global_position: Vector2 = target.global_position
		# calculates the distance from itself to target position
		var to_target = global_position.distance_to(target_global_position)
		# if target is to close, stop moving
		if to_target < followOffset:
			return

		# else, move towards target at speed
		
		#else, move towards target at speed
		var currenctVelocity = velocity.normalized()
		var vectorToTarget: Vector2 = position.direction_to(target.global_position).normalized()

		var newVelocity: Vector2 = currenctVelocity.lerp(vectorToTarget, 0.25)

		var finalVelocity = newVelocity * SPEED
		velocity = finalVelocity

		move_and_slide()
		# by sending it the velocity, it tells the animation blend space which animation direction to pull
		update_animation_parameters(velocity)
	
	# checks each frame if it needs to change to the next animation
	state_machine.travel("Drive")
	
# using the move_input as a vector pointing in some direction, set the animation tree to the correct animation
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Drive/blend_position", move_input)

# checks to see if the snake hit itself, working but needs win condition code
func _on_snake_hurt_box_area_entered(area):
	pass
	# hiding the win condition for now, doesnt work in a satisfying way
#	Events.level_completed.emit()
#	print("Hurt - self collision")
