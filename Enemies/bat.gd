extends Node2D

@export var speed = 300
@onready var player = get_tree().get_first_node_in_group("player")
var piano=preload("res://piano.tscn")
var triggered = false
var sound_has_played = false
var rand = RandomNumberGenerator.new() 
var base = 40
var meter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	meter = get_parent().get_parent().distance
	if  rand.randi_range(0, 100) > base + meter/4:
		queue_free()

	starty=global_position.y
	pass # Replace with function body.
var starty=0;
var counter=0;
var dropped=false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(abs(player.global_position.x-global_position.x)<50 and !dropped):
		dropped=true;
		print("hello")
		var pia=piano.instantiate()
		
		get_parent().add_child(pia)
		pia.global_position=global_position;
		
	counter=counter+0.1;
	if abs(player.global_position.x - global_position.x) < 500:
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
