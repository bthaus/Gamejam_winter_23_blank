extends Node2D
@export var line_width=0.5;

@export var attachment:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	
	draw_line(Vector2(0,0),-(global_position-attachment.global_position),Color.WHITE,line_width,true)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	queue_redraw()
	pass
