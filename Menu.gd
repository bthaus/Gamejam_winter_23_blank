extends Control

var counter=0;
var open=false;
signal closegame;
signal startgame;
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode=Node.PROCESS_MODE_ALWAYS;

	pass # Replace with function body.
var justopened=false;
func toggle(first):
	justopened=first;
	open=!open;
	pass;
func execute():
	if(counter==0):
		closegame.emit()
		$leave/hightlighted.visible=true
	
	if(counter==1):
		$options2/highlighted.visible=true
		
	if(counter==2):
		startgame.emit()
		get_tree().paused=false;
		$stargame/highlighted.visible=true
		open=false;
	
	pass;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!open):
		visible=false;
		return;#
	visible=true;
	

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
