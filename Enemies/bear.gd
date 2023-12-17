extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var counter = 0
var starty
var soundTriggered = false
var alive=true;
var rand = RandomNumberGenerator.new() 
var base = 40
var meter = 0
var gamebert = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	meter = get_parent().get_parent().distance
	if  rand.randi_range(0, 100) > base + meter/4:
		queue_free()
	rand.randomize()
	if  rand.randi_range(0, 100) < 15:
		gamebert =true
		$Sprite2D.texture = load("res://Pictures/Unbenanntes_Projekt.png")
	starty = position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if!alive:
		global_position.y=global_position.y+200*delta;
		if position.y>2000:
			queue_free();
	
	if abs(player.global_position.x - global_position.x) < 200 and !soundTriggered:
		if gamebert:
			$gamebert.play()
		else:
			$bearSound.play()
		soundTriggered = true
	counter=counter+0.1
	if alive:
		position.y = sin(counter)*10+starty
	queue_redraw()
	
func _draw():
	draw_line(Vector2(0, position.y - global_position.y + 5000), Vector2(0, 0), Color.SANDY_BROWN, 25)
func hit(type):
	
	alive=false;
	if gamebert:
		$sadgamebert.play()
	else: 
		$sadbear.play()
	pass;


func _on_area_2d_area_entered(area):
	if area.get_parent().has_method("hit") and alive:
		area.get_parent().hit("bear");
	pass # Replace with function body.
