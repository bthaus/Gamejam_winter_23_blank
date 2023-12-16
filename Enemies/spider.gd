extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var triggered = false
var speed = 200
var goDown = true
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs(player.global_position.x - global_position.x) < 50:
		triggered = true
		
	if goDown and hit:
		goDown = false
		hit = false
	elif !goDown and position.y < 10:
		goDown = true
		triggered = false

	if triggered:
		if goDown:
			position.y += speed * delta
		else:
			position.y -= speed * delta
		queue_redraw()
	
func _on_attack_area_body_entered(body):
	print("hit")
	hit = true
	
func _draw():
	draw_line(Vector2(0, position.y - global_position.y - 5000), Vector2(0, -50), Color.WHITE, 3)
	
