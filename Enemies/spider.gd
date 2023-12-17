extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var triggered = false
var speed = 300
var deadSpeed = 500
var goDown = true
var hitSomething = false
var sound_has_played = false
var dead = false
var stringMoveSteps = 50
var skip = false
var meter = 0
var rand = RandomNumberGenerator.new() 
var base = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	$String.hide()
	rand.randomize()
	meter = get_parent().get_parent().distance
	if  rand.randi_range(0, 100) > base + meter/4:
		queue_free()
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if skip:
		return
		
	if dead:
		position.y += deadSpeed * delta
		if player.onehandbroken or player.twohandbroken or player.leftlegbroken or player.rightlegbroken:
			if stringMoveSteps > 0:
				$String.show()
				$String.global_position.y -= (deadSpeed * 1.10) * delta
				stringMoveSteps = stringMoveSteps - 1
			else:
				$String.hide()
				player.repair()
				skip = true
		return
		
	if abs(player.global_position.x - global_position.x) < 75:
		triggered = true
		if !sound_has_played:
			sound_has_played = true
			$spiderSound.play()
		
	if goDown and hitSomething:
		goDown = false
		
		hitSomething = false
	elif !goDown and position.y < 10:
		goDown = true
		triggered = false

	if triggered:
		if goDown:
			position.y += speed * delta
		else:
			position.y -= speed * delta
		queue_redraw()

func _draw():
	if !dead:
		draw_line(Vector2(0, position.y - global_position.y - 5000), Vector2(0, 0), Color.WHITE, 3)
	
func hit(type):
	if dead:
		return
	dead = true
	queue_redraw()
	
func _on_physics_area_body_entered(body):
	hitSomething = true


func _on_area_2d_area_entered(area):
	if(area.get_parent().has_method("hit") and !dead):
		area.get_parent().hit("spider")
	pass # Replace with function body.
