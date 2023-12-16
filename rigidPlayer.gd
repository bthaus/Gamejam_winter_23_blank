extends RigidBody2D
var maxSpeed = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_pressed("ui_right") and linear_velocity.x < maxSpeed):
		apply_impulse(Vector2(200,0),Vector2(0,0))
	if(Input.is_action_pressed("ui_left") and linear_velocity.x > -maxSpeed):
		apply_impulse(Vector2(-200,0),Vector2(0,0))	
	if(Input.is_action_pressed("ui_up")and abs(linear_velocity.y)<5):
		apply_impulse(Vector2(0,-500),Vector2(0,0))	
	pass


func computecontact(val):
	floorcontacts=floorcontacts+val;
	pass;

var floorcontacts=0;
func _on_feet_body_entered(body):
	if(body==self):
		return;
	computecontact(1)
	pass # Replace with function body.


func _on_feet_body_exited(body):
	if(body==self):
		return;
	computecontact(-1)
	pass # Replace with function body.
