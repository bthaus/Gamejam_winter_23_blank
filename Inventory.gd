


extends Control
var open=false;
var index=0;
var items=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open_inventory():
	visible=true;
	open=true;
	index=0;
	$ItemList.select(0);
	pass

func close_inventory():
	visible=false;
	open=true;
	index=0;
	
	pass
func select_item():
	$ItemList.select(index);
	$ItemList.ensure_current_is_visible()
	pass
	
func remove_active_item():
	$ItemList.remove_item(index);
	items.remove_at(index)
	move_index(0)
	select_item()
	pass
func retrieve_active_item():
	var item=items[index];
	remove_active_item();
	if(item.has_method("on_retrieval")):
		item.on_retrieval();
		
	return item;
func add_item(item):
	var holder;
	var children=item.get_children(false);
	
	for n in children:
		if(n.has_method("get_Type")&&n.get_Type()=="ItemRepresentation"):
			holder=n;
		
	$ItemList.add_item(holder.description,holder.texture);	
	items.append(item);
	select_item()
	
	
	pass

func activate_current_item():
	if(items[index].has_method("activate_item")):
		if(items[index].activate_item()):
			remove_active_item()
	
	pass
	
	
func move_index(val):
	index=index+val;
	if(index>$ItemList.item_count-1):
		print("setting 0")
		index=0;
		return
	
	if(index<0):
		print("setting max")
		index=$ItemList.item_count-1;
		return
	print("inc")
	
		
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!open):
		return;
		
	if(Input.is_action_just_pressed("down")):
		move_index(+1)
		print(index)
		select_item();
	if(Input.is_action_just_pressed("up")):
		move_index(-1)
		print(index)
		select_item()
	if (Input.is_action_just_pressed("throw_item")):
		remove_active_item();
	if(Input.is_action_just_pressed("activate_item")):
		activate_current_item();
	pass
