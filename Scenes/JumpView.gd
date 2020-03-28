extends Control


var start = Vector2(0,0)
var destination = Vector2(0,-200)
var time = 2
var facing = "up"
var y = 0
var reset
var timeTimer = 0
onready var right = $Right



func _physics_process(delta):
	timeTimer += delta
	#-70
	
	if y<-70:
		facing = "down"
		reset = true
	elif y>0:
		facing = "up"
		if reset:
			timeTimer = 0
			reset = false
	
	match facing:
		"down":
			y += delta*200
		"up":
			if timeTimer>time:
				reset = false
				y -= delta*150
	_set_position(Vector2(0,y))
