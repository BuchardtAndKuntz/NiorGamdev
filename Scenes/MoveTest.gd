extends Control


var start = Vector2(215,130)
var destination = Vector2(250,130)
var time = 2
var facing = "Right"
var x = 215
onready var right = $Right
onready var left = $Left



func _physics_process(delta):
	if x>350:
		facing = "Left"
		left.visible = true
		right.visible = false
	elif x<185:
		facing = "Right"
		left.visible = false
		right.visible = true
	
	match facing:
		"Right":
			x += delta*35
		"Left":
			x -= delta*35
	_set_position(Vector2(x,130))
