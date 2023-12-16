extends StaticBody2D

var starty;
# Called when the node enters the scene tree for the first time.
func _ready():
	starty=global_position.y;
	$AnimationPlayer.play("flipcross")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y=starty;
	pass
