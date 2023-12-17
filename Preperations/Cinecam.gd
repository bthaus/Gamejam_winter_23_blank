extends Camera2D

var locked=false;

var shaking=false;
var camera_shake_intensity=1;
var dropoff=1;
var baseoffset;
@onready var sign=preload("res://infolabel.tscn")
@onready var distancelabel=preload("res://distancelabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	baseoffset=self.offset;
	pass # Replace with function body.
var buffcounter=0;
func showLabels(label,isbuff):
	var done=false;
	for n in $points.get_children():
		if !done:
			if n.get_child_count()==0:
				showSign(label,isbuff,n)
				done=true;
			
	pass;
func showSign(label,isbuff,node):
	var s=sign.instantiate();
	s.labelText=label;
	node.add_child(s);
	s.global_position=node.global_position;
	
	pass;
	
func showDistance(label, node):
	var l = distancelabel.instantiate();
	l.labelText = label
	node.add_child(l)
	l.global_position = node.global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if(shaking):
		var offset = Vector2(randf()* camera_shake_intensity,randf()* camera_shake_intensity)  
		offset.x=offset.x+baseoffset.x;
		offset.y=offset.y+baseoffset.y;
		camera_shake_intensity=camera_shake_intensity-delta*dropoff
		self.offset=offset;
	else:
		offset=baseoffset

	pass

#intensity around 2.5 ish, duration 0.2, dropoff ~2 (for a hit-shake eg.) 
func shake(intensity,duration,dropoff):
	self.dropoff=dropoff
	shaking=true;
	camera_shake_intensity=intensity;
	$shaketimer.start(duration);
	pass




func _on_shaketimer_timeout():
	shaking=false;
	pass # Replace with function body.


func _on_labeltimer_timeout():
	$buffs.hide()
	$buffs2.hide()
	$buffs3.hide()
	$nerfs.hide()
	$nerfs2.hide()
	$nerfs3.hide()
	pass # Replace with function body.
