extends KinematicBody2D


var playerVelocity = Vector2.ZERO
export var moveSpeed = 1000
export var fallSpeed = 930


func _process(delta):
	input()
	processmovement()

func processmovement():
	move_and_slide(playerVelocity, Vector2.UP)
	
	


func input():
	playerVelocity  = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		playerVelocity = Vector2.RIGHT*moveSpeed
	if Input.is_action_pressed("ui_left"):
		playerVelocity = Vector2.LEFT*moveSpeed
	
	if !is_on_floor():
		playerVelocity += Vector2(0,fallSpeed)
	#if Input.is_action_just_pressed("ui_down"):
		#Drop down ? 
		
	#if Input.is_action_just_pressed("jump"):
		#Jumå
	
