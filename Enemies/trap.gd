extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
var triggered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_attack_area_body_entered(body):
	if body.is_in_group("player") and !triggered:
		body.hit("trap")
		$Sprite2D.texture = load("res://Pictures/TrapClosed.png")
		$trapSound.play()
		triggered = true
	
