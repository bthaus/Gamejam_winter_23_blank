extends StaticBody2D

var starty;
var playerdied=false;
var locked;
# Called when the node enters the scene tree for the first time.
func _ready():
	starty=100
	$AnimationPlayer.play("flipcross")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position.y=starty+350;
	if playerdied:
		global_position=locked;
	print(locked)
	pass


func _on_body_died():
	locked=global_position;
	print(global_position)
	playerdied=true;
	pass # Replace with function body.
