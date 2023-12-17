extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var counter = 0
var starty
var soundTriggered = false
var alive=true;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	starty = position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if!alive:
		global_position.y=global_position.y+200*delta;
		if position.y>2000:
			queue_free();
	
	if abs(player.global_position.x - global_position.x) < 200 and !soundTriggered:
		$bearSound.play()
		soundTriggered = true
	counter=counter+0.1
	if alive:
		position.y = sin(counter)*10+starty
	queue_redraw()
	
func _draw():
	draw_line(Vector2(0, position.y - global_position.y + 5000), Vector2(0, 0), Color.SANDY_BROWN, 25)
func hit(type):
	print("beasr hit")
	alive=false;
	$bearSound.play()
	pass;
