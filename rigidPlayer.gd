extends RigidBody2D
var maxSpeed = 120
var umbrellaOpen=true;
var onehandbroken=false;
var twohandbroken=false;
var leftlegbroken=false;
var rightlegbroken=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")
	
	pass # Replace with function body.

func breakOneHand():
	$Skeleton2D/hips/shoulders/LeftUpperArm.visible=false;
	$StaticBody2D/alefthand.visible=false;
	$DanglingParts/leftarm.visible=true;
	onehandbroken=true;
	
	pass;
func breakTwoHand():
	$Skeleton2D/hips/shoulders/rightupperarm.visible=false;
	$StaticBody2D/arighthand.visible=false;
	$DanglingParts/rightarm.visible=true;
	$DanglingParts/rightarm/sword/danglingumbrellasprite.frame=$Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame
	twohandbroken=true;
	pass;
	
func breakleftLeg():
	$Skeleton2D/hips/LeftQuad.visible=false;
	$StaticBody2D/aleftfoot.visible=false;
	$DanglingParts/leftlef.visible=true;
	leftlegbroken=true;
	pass;
func breakrightleg():
	print("right broken")
	$Skeleton2D/hips/RightQuad.visible=false;
	$DanglingParts/leftlef2.visible=true;
	$StaticBody2D/arightfoot.visible=false;
	rightlegbroken=true;
	pass;
func closeumbrella():
	
	pass;
func hit():
	print("umbrella closed")
	umbrellaOpen=true;
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if(Input.is_action_just_pressed("activate_item")):
		if(leftlegbroken):
					breakrightleg()
		if(twohandbroken):
				breakleftLeg()
		if(onehandbroken):
			breakTwoHand()
		breakOneHand();
		
	if(Input.is_action_just_pressed("switch")):
		print(umbrellaOpen)
		if($Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame>1) :
			if(!onehandbroken):
				umbrellaOpen=false;
				$AnimationPlayer2.play("closeumbrella")	
		else:
			$AnimationPlayer2.play("openumbrella")
			umbrellaOpen=false;
				
	if(Input.is_action_just_pressed("attack") and $Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame<2):
		$AnimationPlayer2.play("attack")			
	if(Input.is_action_pressed("ui_right") and linear_velocity.x < maxSpeed):
		apply_impulse(Vector2(200,0),Vector2(0,0))
		print("run")
		$AnimationPlayer.play("run")
	if(Input.is_action_pressed("ui_left") and linear_velocity.x > -maxSpeed):
		apply_impulse(Vector2(-200,0),Vector2(0,0))	
		$AnimationPlayer.play("run")
	if(Input.is_action_pressed("ui_up")and abs(linear_velocity.y)<5) and floorcontacts>0 and !jumping:
		jumping=true;
		$AnimationPlayer.play("jump")
		apply_impulse(Vector2(0,-1000),Vector2(0,0))	
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


func _on_animation_player_animation_finished(anim_name):
	print("finished")
	$AnimationPlayer.play("idle")
	pass # Replace with function body.
