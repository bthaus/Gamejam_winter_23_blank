extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit(type):
	$crash.play()
	$Area2D/CollisionShape2D.disabled=true;
	collision_layer=0;
	$RigidBody2D2.collision_layer=0;
	if $Area2D/PinJoint2D!=null:
		$Area2D/PinJoint2D.free()
	collision_mask=0;
	$RigidBody2D2.collision_mask=0
var hitted=false;
func _on_area_2d_area_entered(area):
	if area==$Area2D:
		return;
	
	if! hitted:
		$crash.play()
	if(hitted):
		return
	hitted=true;
	if(area.get_parent().has_method("hit")):
		area.get_parent().hit("piano")
	pass # Replace with function body.


func _on_body_entered(body):
	if body==$RigidBody2D2:
		return;
	if body==self:
		return;
	hitted=true;
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if!hitted:
		$crash.play()
	pass # Replace with function body.
