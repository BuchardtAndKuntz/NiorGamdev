extends Control


var start = Vector2(700,130)
var destination = Vector2(700,200)
var time = 2
var facing = "Right"
var y = 130
onready var right = $Right



func _physics_process(delta):
	if y>200:
		facing = "down"
	elif y<130:
		facing = "up"
	
	match facing:
		"down":
			y += delta*35
		"up":
			y -= delta*115
	_set_position(Vector2(700,y))
