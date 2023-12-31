extends Node2D

var level1 = preload("res://Scenes/level0.tscn").instantiate()
var levelSpeed = 200
var levelPosX = 0
var distance = 0
var levels = []
var rand = RandomNumberGenerator.new()
var count = 0
var lastDistance = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused=true;
	rand.randomize()
	add_child(level1)
	levels.push_front(level1)
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!$Camera2D/AudioStreamPlayer2D.playing):
		$Camera2D/AudioStreamPlayer2D.play()
	distance = roundi($Camera2D.position.x/100)
	if(Input.is_action_just_pressed("menu")):
		get_tree().paused=true;
		$Camera2D/menu.toggle($Player.alive)
	
	if(Input.is_action_just_pressed("open_menu")):
		get_tree().reload_current_scene()
	
	if distance % 25 == 0 and distance != lastDistance:
		$Camera2D.showDistance(str(distance, "cm"), $Camera2D/distance)
		lastDistance = distance
		
	$Camera2D.position.x += levelSpeed * delta
	$Wall.position.x += levelSpeed * delta
	if $Camera2D.position.x - levelPosX > 600:
		if levels.size() > 2:
			remove_child(levels.pop_front())
		var level
		if count > 2:
			level = load("res://Scenes/level0.tscn").instantiate()
			count = 0
		else:
			level = load("res://Scenes/level"+ str(rand.randi_range(0,7)) +".tscn").instantiate()
			count = count + 1
		level.position.x = levelPosX + 1150
		levelPosX = level.position.x
		levels.push_back(level)
		add_child(level)

func _on_player_died():
	$Camera2D/deathshower.play("show")
	$dietimer.start()
	pass # Replace with function body.


func _on_dietimer_timeout():
	$Camera2D/deathshower.play("hide")
	$Camera2D/menu.toggle(false)
	pass # Replace with function body.


func _on_deathzone_area_entered(area):
	
	pass # Replace with function body.


func _on_deathzone_body_entered(body):
	print("entered")
	if body.has_method("breakiteratively"):
		body.breakiteratively();
		body.breakiteratively();
		if !body.alive:
			return
		body.position.y=300
		body.position.x=body.position.x+200
		
		
		
		
	pass # Replace with function body.




func _on_area_2d_body_entered(body):
	print("entered")
	if body.has_method("breakiteratively"):
		body.breakiteratively();
		if !body.alive:
			return
		body.position.y=300
		body.position.x=body.position.x+500
		
	pass # Replace with function body.
