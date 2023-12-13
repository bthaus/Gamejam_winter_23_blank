


extends Control
var open=false;
var index=0;
var activeSnippet:DialogSnippet;
var nodes=[]
var start;
@export var autoclosing=false;
@export var closeOption:String="go away"
signal dialog_closed
signal dialog_advanced
var defaultClosingSnippet;


# Called when the node enters the scene tree for the first time.
func _ready():
	var children=get_children(false);
	activeSnippet=children[2]
	start=activeSnippet;
	load_active_snippet();
	defaultClosingSnippet=load("res://DialogSnippet.tscn").instantiate()
	defaultClosingSnippet.dialogOption=closeOption;
	defaultClosingSnippet.isExiting=true;
	
	
	
	
	pass # Replace with function body.

func load_active_snippet():
	$active.text=activeSnippet.dialog;
	$ItemList.clear();
	index=0;
	
	if(activeSnippet.get_child_count(false)>0):
		nodes=activeSnippet.get_children(false);
		for n in nodes:
			if(n.visible):
				$ItemList.add_item(n.dialogOption)
	else:
		if(autoclosing):
			close_dialog()
			return;
		nodes.clear();
		nodes.append(defaultClosingSnippet)
		$ItemList.add_item(defaultClosingSnippet.dialogOption)
	select_item()
	pass

func chose_selected_dialog_option():
	activeSnippet=nodes[index];
	activeSnippet.select_option();
	dialog_advanced.emit(activeSnippet)
	if(activeSnippet.isExiting):
		close_dialog()
		return;
	
		
	if(activeSnippet.jumps):
		var all=get_all_children(start)
		all.append(start)
		for n in all:
			if(n.key==activeSnippet.jumpKey):
				activeSnippet=n;
	
	
					
	load_active_snippet()
	pass
	
func open_dialog():
	visible=true;
	open=true;
	index=0;
	$ItemList.select(0);
	pass

func close_dialog():
	visible=false;
	open=true;
	index=0;
	dialog_closed.emit()
	_on_close_dialog()
	
	pass
	
	#to be overwritten
func _on_close_dialog():

	pass
func select_item():
	$ItemList.select(index);
	$ItemList.ensure_current_is_visible()
	pass
	




	

func get_all_children(node):
	var nodes=[];
	for n in node.get_children():
		if(n.get_child_count()>0):
			nodes.append(n)
			nodes.append_array(get_all_children(n))
		else:
			nodes.append(n)	
	
	return nodes;

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
	
	if(Input.is_action_just_pressed("activate_item")):
		chose_selected_dialog_option();
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	self.index=index;
	select_item()
	chose_selected_dialog_option()
	pass # Replace with function body.
