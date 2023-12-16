extends Node2D

@export var attachment:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	
	draw_line(Vector2(0,0),-(global_position-attachment.global_position),Color.WHITE,2)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(attachment.global_position)
	queue_redraw()
	pass
