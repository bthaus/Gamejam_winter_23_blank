extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var jumpFactor=2;
@export var jumpStrenght=2;
@export var speedFactor=2;
@export var speed=10;
var leftlegcut=false;
var rightlegcut=false;
var armcut=false;
var umbrellaOpen=false;


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		var factor=1;
		if(leftlegcut):
			factor=factor*0.5;
		if(leftlegcut):
			factor=factor*0.5;
		velocity.y = JUMP_VELOCITY*jumpStrenght*factor;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
