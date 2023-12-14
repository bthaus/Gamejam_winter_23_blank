extends Camera2D
var target;
var locked=false;

var shaking=false;
var camera_shake_intensity=1;
var dropoff=1;
var baseoffset;
# Called when the node enters the scene tree for the first time.
func _ready():
	target= get_parent()
	
	baseoffset=self.offset;
	
	pass # Replace with function body.

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
	
	if Input.is_action_just_pressed("lock_camera"):
		locked=!locked;
	if(locked):
		if Input.is_action_pressed("camera_down"):
			position.y=position.y+500*delta;
		if Input.is_action_pressed("camera_up"):
			position.y=position.y-500*delta;
		if Input.is_action_pressed("camera_left"):
			position.x=position.x-500*delta;
		if Input.is_action_pressed("camera_right"):
			position.x=position.x+500*delta;
		return;
	
	position.x=target.position.x
	position.y=target.position.y
	
	pass

#intensity around 2.5 ish, duration 0.2, dropoff ~2 (for a hit-shake eg.) 
func shake(intensity,duration,dropoff):
	self.dropoff=dropoff
	shaking=true;
	camera_shake_intensity=intensity;
	$shaketimer.start(duration);

	
	pass


func _on_timer_timeout():
	shaking=false;
	pass # Replace with function body.
