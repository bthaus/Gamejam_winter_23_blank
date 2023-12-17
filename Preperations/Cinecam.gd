extends Camera2D

var locked=false;

var shaking=false;
var camera_shake_intensity=1;
var dropoff=1;
var baseoffset;
# Called when the node enters the scene tree for the first time.
func _ready():
	baseoffset=self.offset;
	pass # Replace with function body.
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
