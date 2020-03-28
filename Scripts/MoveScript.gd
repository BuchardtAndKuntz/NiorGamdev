extends KinematicBody2D

var playerVelocity = Vector2.ZERO
export var moveSpeed = 600
export var fallSpeed = 53
export var jumpHeight = 1000
export var glideSpeed = 120
export var maxFallSpeed = 1200
var midAir = false
var hasDoubleJumped = false
var isGliding = false



func _physics_process(delta):
	print("Player vel y: " + str(playerVelocity.y))
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
		midAir = true
		if isGliding:
			playerVelocity.y = glideSpeed
		else:
			if playerVelocity.y < maxFallSpeed:
				playerVelocity += Vector2.DOWN*fallSpeed
				if playerVelocity.y > maxFallSpeed:
					playerVelocity.y = maxFallSpeed
	
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()

func processJump():
	#If we are jumping action is pressed go up
	if Input.is_action_just_pressed("jump"):
		if not midAir:
			jump()
		elif midAir && not hasDoubleJumped:
			doubleJump()
			
	#If we stop pressing jump we stop the upwards momentum
	if Input.is_action_just_released("jump") && not is_on_floor():
		if playerVelocity.y<0: 
			playerVelocity.y=0
		
		#Are we falling? then are we gliding? 
	if not is_on_floor() && playerVelocity.y>=0:
			glide()
	#Are we back on the floor? then reset jumps
	if is_on_floor():
		midAir = false
		hasDoubleJumped = false
		if !Input.is_action_just_pressed("jump"):
			playerVelocity.y = 0

#Single jump
func jump():
	playerVelocity.y = -jumpHeight
	midAir = true
#Midair jump
func doubleJump():
	if AbilityFlags.hasDoubleJump:
		playerVelocity.y = -jumpHeight
		hasDoubleJumped = true
#Midair glide
func glide():
	if AbilityFlags.hasGlide:
		isGliding = Input.is_action_pressed("jump")
	else:
		isGliding = false
