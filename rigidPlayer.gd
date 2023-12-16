extends RigidBody2D
var maxSpeed = 120
var onehandbroken=false;
var twohandbroken=false;
var leftlegbroken=false;
var rightlegbroken=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func breakOneHand():
	$Skeleton2D/hips/shoulders/LeftUpperArm.visible=false;
	$StaticBody2D/alefthand.visible=false;
	$DanglingParts/leftarm.visible=true;
	
	
	
	
	pass;
func breakTwoHand():
	
	pass;
	
func breakleftLeg():
	
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if(Input.is_action_just_pressed("activate_item")):
		breakOneHand();
	if(Input.is_action_pressed("ui_right") and linear_velocity.x < maxSpeed):
		apply_impulse(Vector2(200,0),Vector2(0,0))
	if(Input.is_action_pressed("ui_left") and linear_velocity.x > -maxSpeed):
		apply_impulse(Vector2(-200,0),Vector2(0,0))	
	if(Input.is_action_pressed("ui_up")and abs(linear_velocity.y)<5) and floorcontacts>0 and !jumping:
		jumping=true;
		apply_impulse(Vector2(0,-500),Vector2(0,0))	
	pass


	
func computecontact(val):
	floorcontacts=floorcontacts+val;
	pass;

var floorcontacts=0;
var jumping=false;
func _on_feet_body_entered(body):
	jumping=false;
	print("touching tralala" +str(floorcontacts))
	if(body==self):
		return;
	computecontact(1)
	pass # Replace with function body.


func _on_feet_body_exited(body):
	if(body==self):
		return;
	computecontact(-1)
	pass # Replace with function body.