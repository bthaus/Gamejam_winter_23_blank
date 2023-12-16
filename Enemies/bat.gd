extends Node2D

@export var speed = 300
@onready var player = get_tree().get_first_node_in_group("player")
var triggered = false
var sound_has_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	starty=global_position.y
	pass # Replace with function body.
var starty=0;
var counter=0;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter=counter+0.1;
	if abs(player.global_position.x - global_position.x) < 1000:
		triggered = true
		if !sound_has_played:
			sound_has_played = true
			$batSound.play()
	if triggered:
		position.x -= speed * delta
		position.y =sin(counter)*30+starty
	queue_redraw()
		
func _draw():
	draw_line(Vector2(0, 0), Vector2(200, position.y - 2000), Color.SADDLE_BROWN, 15) 
