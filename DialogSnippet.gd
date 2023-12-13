class_name DialogSnippet
extends Node
@export var dialog:String="I am what is printed"
@export var dialogOption="I am what is printed in parentNode"
@export var key:String="for jumps"
@export var jumps:bool=false;
@export var jumpKey:String="-1";
@export var visible=true;
@export var isExiting=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func select_option():
	print("not overwritten")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
