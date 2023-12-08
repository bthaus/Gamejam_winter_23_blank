extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("open_menu")):
		print("menu opened")
		$Inventory.open_inventory();
		
	if (Input.is_action_pressed("close_menu")):
		$Inventory.close_inventory();
	if(Input.is_action_just_pressed("pick_up_item")):
		$Inventory.add_item($Item)
	
	pass
