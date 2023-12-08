@tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
	
func activate_item()->bool:
	print("i have been activated!")
	return true;
	
func _get_configuration_warnings():
	var arr=PackedStringArray([])
	var children=get_children(false);
	if(children.size()==0):
		arr.append("You need to add an inventoryrepresentation to this item.");
	else:
		var found=false;
		for n in children:
			if(n.has_method("get_Type")&&n.get_Type()=="ItemRepresentation"):
				found=true;
		if(!found):
			arr.append("You need to add an inventoryrepresentation to this item.");

	return arr;
