extends RigidBody2D

var starty;
# Called when the node enters the scene tree for the first time.
func _ready():
	starty=position.y;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_pressed("up")):
		position.y=position.y-10;
	pass
