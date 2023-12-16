extends Node2D
@export var curtain:AnimatedSprite2D;

var counter=0;
var open=true;
signal closegame;
signal startgame;
# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()
	for n in get_children():
		print(n)
	print($test2/curtain)
	
	process_mode=Node.PROCESS_MODE_ALWAYS;

	pass # Replace with function body.
var died=false;
var alives=true;
func toggle(alive):
	$music.play()
	alives=alive;
	open=!open;
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
		
	if(counter==2):
		startgame.emit()
		$test2/curtain.play("open")
		get_tree().paused=false;
		$stargame/highlighted.visible=true
		$music.stop()
		open=false;
	
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!open):
		$leave.visible=false;
		$options2.visible=false;
		$stargame.visible=false;
		return;#
		
	$leave.visible=true;
	$options2.visible=true;
	$stargame.visible=true;

	if(Input.is_action_just_pressed("ui_up")):
		counter=counter+1;
		counter=counter%3;
	if(Input.is_action_just_pressed("ui_down")):
		counter=counter-1;
		counter=counter%3;
	if(Input.is_action_just_pressed("activate_item")):
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
	print(counter)
	
	pass


func _on_curtain_animation_finished():
	if(!alives):
		get_tree().reload_current_scene();
	pass # Replace with function body.
