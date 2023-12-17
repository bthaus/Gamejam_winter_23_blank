extends Node2D

var moveIn = true
var labelText = ""
var moveSpeed = 200
var moveDistance = 700
var startx
var starty
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = labelText
	startx = position.x
	starty = position.y
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $ShowTimer.time_left > 0:
		return
	counter += 0.1
	if moveIn:
		position.x -= moveSpeed * delta;
		position.y = sin(counter)*5+starty
	else:
		position.x += moveSpeed * delta;
		position.y = sin(counter)*5+starty
	if moveIn and startx - position.x >= moveDistance:
		$ShowTimer.start()
	if !moveIn and position.x >= startx:
		queue_free()

func _on_show_timer_timeout():
	moveIn = false
	
