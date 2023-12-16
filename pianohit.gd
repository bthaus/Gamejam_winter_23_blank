extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	print()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit():
	$Area2D/CollisionShape2D.disabled=true;
	collision_layer=0;
	$RigidBody2D2.collision_layer=0;
	$Area2D/PinJoint2D.free()
	collision_mask=0;
	$RigidBody2D2.collision_mask=0
var hitted=false;
func _on_area_2d_area_entered(area):
	$crash.play()
	if(hitted):
		return
	
	if(area.get_parent().has_method("hit")):
		hitted=true;
		area.get_parent().hit("piano")
	pass # Replace with function body.


func _on_body_entered(body):
	
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	$crash.play()
	pass # Replace with function body.
