extends KinematicBody2D


var playerVelocity = Vector2.ZERO



func _process(delta):
	input()
	processmovement()

func processmovement():
	move_and_slide(playerVelocity, Vector2.UP)
	


func input():
	playerVelocity  = Vector2.ZERO
	if Input.is_action_just_pressed("ui_right"):
		print("clicked right")
		playerVelocity = Vector2.RIGHT
	if Input.is_action_just_pressed("ui_left"):
		playerVelocity = Vector2.LEFT
	
	#if Input.is_action_just_pressed("ui_down"):
		#Drop down ? 
		
	#if Input.is_action_just_pressed("jump"):
		#Jumå
	
