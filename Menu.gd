extends Node2D
@export var curtain:AnimatedSprite2D;
@export var world:Node2D;
var counter=2;
var open=true;
signal closegame;
signal startgame;
var state="menu"
# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()
	$expl/highscore.text=str(Permanent.highscore)
	for n in get_children():
		print(n)
	print($test2/curtain)
	
	process_mode=Node.PROCESS_MODE_ALWAYS;

	pass # Replace with function body.
var died=false;
var alives=true;
func toggle(alive):
	$test2/Publikummover.play("movein")
	$music.play()
	alives=alive;
	open=!open;
	togglemenu(true)
	if(open):
		$test2/curtain.play("open")
		$test2/curtain.play("close")
	pass;
func execute():
	
	if(counter==0):
		closegame.emit()
		$leave/hightlighted.visible=true
	
	if(counter==1):
		$options2/highlighted.visible=true
		togglemenu(false)
		state="tut"
		toggletut(true)
		
	if(counter==2):
		startgame.emit()
		$test2/curtain.play("open")
		get_tree().paused=false;
		$stargame/highlighted.visible=true
		$test2/Publikummover.play("moveaway")
		$tut/Label4.hide()
		$music.stop()
		open=false;
	
	pass;
var tutcounter=0;
func toggletut(bo):
	
	tutcounter=(tutcounter+1)%5
	if tutcounter==1:
		$test2/Publikummover.play("moveaway")
		$tut/first.show()
		$tut/Label4.show();
	if tutcounter==2:
		$tut/first.hide()
		$tut/second.show()
	if tutcounter==3:
		$tut/second.hide()
		$tut/third.show()
	if tutcounter==4:
		$tut/third.hide()
		$tut/fourth.show()
	if tutcounter==0:
		$tut/fourth.hide()
		togglemenu(true)
		$tut/Label4.hide();
		
		
	pass;
func togglemenu(bo):
	$leave.visible=bo;
	$options2.visible=bo;
	$stargame.visible=bo;
	$expl.visible=bo;
	state="menu"
	
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if world.distance>float($expl/highscore.text) and trackscore:
		$expl/highscore.text=str(world.distance)
		Permanent.highscore=world.distance;
	if(!open):
		togglemenu(false)
		return;#
		
	if state=="tut":
		if Input.is_action_just_pressed("attack"):
			toggletut(true)
			return
	if state=="menu":
		if(Input.is_action_just_pressed("ui_up")):
			counter=counter+1;
			counter=counter%3;
		if(Input.is_action_just_pressed("ui_down")):
			counter=counter-1;
			counter=counter%3;
		if(Input.is_action_just_pressed("attack")):
			execute();
		if(counter<0):
			counter=2
		if(counter==0):
			$leave/hightlighted.visible=true
		else:
			$leave/hightlighted.visible=false
		if(counter==1):
			$options2/highlighted.visible=true
		else:
			$options2/highlighted.visible=false
		if(counter==2):
			$stargame/highlighted.visible=true
		else:
			$stargame/highlighted.visible=false
	
	
	pass


func _on_curtain_animation_finished():
	if(!alives):
		get_tree().reload_current_scene();
	pass # Replace with function body.

var trackscore=true;
func _on_player_died():
	trackscore=false;
	pass # Replace with function body.
