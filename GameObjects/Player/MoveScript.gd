extends KinematicBody2D

var playerVelocity = Vector2.ZERO
export var moveSpeed = 600
export var fallSpeed = 93
export var jumpHeight = 2000
export var glideSpeed = 30
var jumped = false
var hasDoubleJumped = false
var isGliding = false

func _physics_process(delta):
	
	processmovement()
	input()

func processmovement():
	move_and_slide(playerVelocity, Vector2.UP)
	
	

func input():
	playerVelocity.x = 0
	if Input.is_action_pressed("ui_right"):
		playerVelocity += Vector2.RIGHT*moveSpeed
	if Input.is_action_pressed("ui_left"):
		playerVelocity += Vector2.LEFT*moveSpeed
	processJump()
	
	if !is_on_floor():
		if isGliding:
			playerVelocity += Vector2.DOWN*glideSpeed
		else:
			playerVelocity += Vector2.DOWN*fallSpeed
	
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()

func processJump():
	#If we are jumping action is pressed go up
	if Input.is_action_just_pressed("jump"):
		if not jumped:
			jump()
		elif jumped && not hasDoubleJumped:
			doubleJump()
	if hasDoubleJumped:
		isGliding = Input.is_action_pressed("jump")
	#If we stop pressing jump we stop the upwards momentum
	if Input.is_action_just_released("jump") && not is_on_floor():
		if playerVelocity.y<0: 
			playerVelocity.y=0
	if is_on_floor():
		jumped = false
		hasDoubleJumped = false

func jump():
	playerVelocity.y = -jumpHeight
	jumped = true
func doubleJump():
	playerVelocity.y = -jumpHeight
	hasDoubleJumped = true
