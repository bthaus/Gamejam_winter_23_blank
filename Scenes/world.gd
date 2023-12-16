extends Node2D

var level1 = preload("res://Scenes/level1.tscn").instantiate()
var levelSpeed = 10
var levelPosX = 0
var levels = []
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	add_child(level1)
	levels.push_front(level1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position.x += levelSpeed * delta
	$Wall.position.x += levelSpeed * delta
	if $Camera2D.position.x - levelPosX > 600:
		if levels.size() > 2:
			remove_child(levels.pop_front())
		var level = load("res://Scenes/level"+ str(rand.randi_range(1,1)) +".tscn").instantiate()
		level.position.x = $Camera2D.position.x + 350
		levelPosX = level.position.x
		levels.push_back(level)
		add_child(level)