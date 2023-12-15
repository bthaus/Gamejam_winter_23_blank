extends RigidBody2D
var maxSpeed = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(linear_velocity.y)
	if(Input.is_action_pressed("ui_right") and linear_velocity.x < maxSpeed):
		apply_impulse(Vector2(200,0),Vector2(0,0))
		print("here")
	if(Input.is_action_pressed("ui_left") and linear_velocity.x > -maxSpeed):
		apply_impulse(Vector2(-200,0),Vector2(0,0))	
	if(Input.is_action_pressed("ui_up")and abs(linear_velocity.y)<5):
		apply_impulse(Vector2(0,-1000),Vector2(0,0))	
	pass
