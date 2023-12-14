@tool
extends Node2D

@export var itemName="itemname";
@export var description="hi im item"
@export var selectable=true;
@export var disabled=false;
@export var texture:Texture;




# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func get_Type():
	return "ItemRepresentation"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_configuration_warnings():
	var arr=PackedStringArray([])
	var parent=get_parent()
	if(parent==null):
		arr.append("This is a dangling Inv Rep. Put into an item")
	if(!parent.has_method("activate_item")):
		arr.append("Parent node needs activate_item() method.")
	return arr;
