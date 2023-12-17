extends StaticBody2D
@export var player:Node2D;
var starty;
var playerdied=false;
var locked;
# Called when the node enters the scene tree for the first time.
func _ready():
	starty=100
	$AnimationPlayer.play("flipcross")
	reparent(player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position.y=starty+350;
	if playerdied:
		global_position=locked;
		reparent(get_parent().get_parent())
		
		
	
	
	pass


func _on_body_died():
	locked=global_position;
	print(global_position)
	playerdied=true;
	$free.start()
	pass # Replace with function body.


func _on_free_timeout():
	queue_free()
	pass # Replace with function body.
