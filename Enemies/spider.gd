extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var triggered = false
var speed = 200
var goDown = true
var hitSomething = false
var sound_has_played = false
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		position.y += 500 * delta
		return
		
	if abs(player.global_position.x - global_position.x) < 50:
		triggered = true
		if !sound_has_played:
			sound_has_played = true
			$spiderSound.play()
		
	if goDown and hitSomething:
		goDown = false
		hit()
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
	
func hit():
	dead = true
	
func _on_physics_area_body_entered(body):
	hitSomething = true
