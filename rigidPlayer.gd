extends RigidBody2D
var maxSpeed = 320
var jumpfactor=2;
var umbrellaOpen=true;
var onehandbroken=false;
var twohandbroken=false;
var leftlegbroken=false;
var rightlegbroken=false;
var alive=true;
signal died;
var damages=[]
var direction="right";
var buffcounter=0;
var nerfcounter=0;

func showLabels(label,isbuff):
	if isbuff:
		buffcounter=(buffcounter+1)%3;
		if buffcounter==0:
			$buffs.text=label;
			$buffs.show()
		if buffcounter==1:
			$buffs2.text=label;
			$buffs2.show()
		if buffcounter==2:
			$buffs3.text=label;
			$buffs3.show()
	else:
		nerfcounter=(nerfcounter+1)%3;
		if nerfcounter==0:
			$nerfs.text=label;
			$nerfs.show()
		if nerfcounter==1:
			$nerfs2.text=label;
			$nerfs2.show()
		if nerfcounter==2:
			$nerfs3.text=label;
			$nerfs3.show()
	$labeltimer.start();
	
	pass;
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")
	global_position=Vector2(128,502)
	pass # Replace with function body.
func playstringrip():
	$stringrip.play()
	pass;
func breakOneHand():
	damages.append("lefthand")
	playstringrip()
	$Skeleton2D/hips/shoulders/LeftUpperArm.visible=false;
	$StaticBody2D/alefthand.visible=false;
	$DanglingParts/leftarm.visible=true;
	onehandbroken=true;
	showLabels("you cant close your umbrella anymore!",false)
	
	
	pass;
func die():
	playstringrip()
	died.emit()
	$StaticBody2D/acenter.visible=false;
	lock_rotation=false;
	alive=false;
	$die.play()
	$centerstring.visible=true;
	pass;
func breakTwoHand():
	damages.append("righthand")
	playstringrip()
	$Skeleton2D/hips/shoulders/rightupperarm.visible=false;
	$StaticBody2D/arighthand.visible=false;
	$DanglingParts/rightarm.visible=true;
	$DanglingParts/rightarm/sword/danglingumbrellasprite.frame=$Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame
	twohandbroken=true;
	showLabels("you cant attack or block!",false)
	
	pass;
	
func breakleftLeg():
	damages.append("leftleg")
	playstringrip()
	$Skeleton2D/hips/LeftQuad.visible=false;
	$StaticBody2D/aleftfoot.visible=false;
	$DanglingParts/leftlef.visible=true;
	leftlegbroken=true;
	maxSpeed=maxSpeed*0.7;
	jumpfactor=jumpfactor*0.8;
	showLabels("Slowed",false)
	showLabels("reduced jump-height",false)
	
	
	pass;
func breakrightleg():
	damages.append("rightleg")
	playstringrip()
	print("right broken")
	$Skeleton2D/hips/RightQuad.visible=false;
	$DanglingParts/leftlef2.visible=true;
	$StaticBody2D/arightfoot.visible=false;
	rightlegbroken=true;
	maxSpeed=maxSpeed*0.5;
	jumpfactor=jumpfactor*0.8;
	showLabels("Slowed",false)
	showLabels("reduced jump-height",false)
	pass;
func repair():
	var repair=damages.pop_back()
	if(repair=="lefthand"):
		$Skeleton2D/hips/shoulders/LeftUpperArm.visible=true;
		$StaticBody2D/alefthand.visible=true;
		$DanglingParts/leftarm.visible=false;
		showLabels("you can open your umbrella again!",true)
	
		onehandbroken=false;
		return;
	if(repair=="righthand"):
		$Skeleton2D/hips/shoulders/rightupperarm.visible=true;
		$StaticBody2D/arighthand.visible=true;
		$DanglingParts/rightarm.visible=false;
		$DanglingParts/rightarm/sword/danglingumbrellasprite.frame=$Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame
		twohandbroken=false;
		showLabels("you can attack again!",true)
		return;
	if(repair=="leftleg"):
		$Skeleton2D/hips/LeftQuad.visible=true;
		$StaticBody2D/aleftfoot.visible=true;
		$DanglingParts/leftlef.visible=false;
		leftlegbroken=false;
		maxSpeed=maxSpeed*1.4;
		jumpfactor=jumpfactor*1.2;
		showLabels("sped up!",true)
		showLabels("increased jump-height",true)
		return;
	if(repair=="rightleg"):
		$Skeleton2D/hips/RightQuad.visible=true;
		$DanglingParts/leftlef2.visible=false;
		$StaticBody2D/arightfoot.visible=true;
		rightlegbroken=false;
		maxSpeed=maxSpeed*2;
		jumpfactor=jumpfactor*1.2;
		showLabels("sped up!",true)
		showLabels("increased jump-height",true)
		return;
		
	pass;
func hit(type):

	if(type=="trap"):
		if(!leftlegbroken):
			breakleftLeg();
		elif(!rightlegbroken):
			breakrightleg()
		else:
			die()
	if$AnimationPlayer2.current_animation=="attack":
		return;
	if type=="bear":
		breakiteratively()
	if(type=="spider"):
		breakiteratively();
			
	if(blocking and type!="trap"):
		print("quickclose")
		$Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame=0
		
		return;
	$gettinghit.play()
	if(type=="piano"):
		breakiteratively();
	
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func breakiteratively():
	if(rightlegbroken&&leftlegbroken&&twohandbroken):
		die();
		return;
	if(!onehandbroken):
		breakOneHand();
		return;
	if(!twohandbroken):
		breakTwoHand();
		return;
	if(!leftlegbroken):
		breakleftLeg()
		return;
	if(!rightlegbroken):
		breakrightleg();
		return;
		
var blocking=false;	
var canblock=true;
func _process(delta):
	if(Input.is_action_just_pressed("activate_item")):
		breakiteratively()
	blocking=false;
	if(!alive):
		return;
	
	gravity_scale=1;
	
	
	if(Input.is_action_just_pressed("pick_up_item")):
		repair();
	if(Input.is_action_just_pressed("switch")):
		print(umbrellaOpen)
		if($Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame>1) :
			if(!onehandbroken):
				umbrellaOpen=false;
				$AnimationPlayer2.play("closeumbrella")	
		else:
			$AnimationPlayer2.play("openumbrella")
			umbrellaOpen=false;
	$shieldbox/CollisionShape2D.disabled=true			
	if(Input.is_action_pressed("attack") ):
		if( $Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame<2):
			$AnimationPlayer2.play("attack")	
		else:
			$shieldbox/CollisionShape2D.disabled=false
			$AnimationPlayer2.play("block")	
			gravity_scale=0.2
			blocking=true;
	if(Input.is_action_pressed("ui_right") and linear_velocity.x < maxSpeed):
		apply_impulse(Vector2(200,0),Vector2(0,0))
		direction="right"
		
		$AnimationPlayer.play("run")
	if(Input.is_action_pressed("ui_left") and linear_velocity.x > -maxSpeed):
		apply_impulse(Vector2(-200,0),Vector2(0,0))	
		direction="left"
		
		$AnimationPlayer.play("run")
	if(Input.is_action_pressed("ui_up")and abs(linear_velocity.y)<5) and floorcontacts>0 and !jumping:
		jumping=true;
		$AnimationPlayer.play("jump")
		apply_impulse(Vector2(0,-1000*jumpfactor),Vector2(0,0))	
	pass


func testdisabled():
	print($Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/hitbox/hitboxshape.disabled)
	pass
	
func computecontact(val):
	floorcontacts=floorcontacts+val;
	pass;

var floorcontacts=0;
var jumping=false;
func _on_feet_body_entered(body):
	jumping=false;
	
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


func _on_hitbox_area_entered(area):
	print("area entered")
	if(area.get_parent().has_method("hit")) :
		print("call hit")
		area.get_parent().hit("player");
	pass # Replace with function body.


func _on_feet_area_entered(area):
	if area.get_parent().has_method("hit") and linear_velocity.y>150:
		$die.play()
		area.get_parent().hit("feet");
	pass # Replace with function body.





func _on_shieldbox_area_entered(area):
	$Skeleton2D/hips/shoulders/rightupperarm/rightLowerArm/swordskelly/swordsprite.frame=0
	pass # Replace with function body.


func _on_labeltimer_timeout():
	$buffs.hide()
	$buffs2.hide()
	$buffs3.hide()
	$nerfs.hide()
	$nerfs2.hide()
	$nerfs3.hide()
	pass # Replace with function body.
