extends KinematicBody2D

var playerVelocity = Vector2.ZERO
export var moveSpeed = 600
export var fallSpeed = 53
export var jumpHeight = 1000
export var glideSpeed = 400
export var maxFallSpeed = 1200
var minGravitiy = 5
var midAir = false
var hasDoubleJumped = false
var isGliding = false
var shouldResetYVel = false
var facing = "Right"
var action = "Idle"
onready var animationSprite = $PlayerSprite
onready var tileMap = get_parent().get_node("TileMap")
var flower_path = "res://GameObjects/Flower/FlowerTemp.tscn"
onready var flower_root_node = get_parent().get_node("GrowingFlowers")
var growingCheckDelay = 0.1
var growingCheckTimer = 0

func getName():
	return "Player"

func _physics_process(delta):
	processmovement()
	input()
	processAnimation()
	# check_growing(delta)
	
	# print("hasDoubleJumped: " + str(hasDoubleJumped) + " - midAir: " + str(midAir))

func playFanfare():
	$PickUpSFX.stream = SoundController.Fanfare
	$PickUpSFX.play()

func playGrab():
	$PickUpSFX.stream = SoundController.Grab
	$PickUpSFX.play()

func playPoof():
	$JumpSFX.stream = SoundController.Jump1
	$JumpSFX.play()

func playPoof2():
	$JumpSFX.stream = SoundController.Jump2
	$JumpSFX.play()


func processAnimation():
	match action:
		"Idle":
			if facing == "Right":
				animationSprite.play("RightIdle")
			elif facing == "Left":
				animationSprite.play("LeftIdle")
		"Move":
			if facing == "Right":
				animationSprite.play("RightMove")
			elif facing == "Left":
				animationSprite.play("LeftMove")

func processmovement():
	move_and_slide(playerVelocity, Vector2.UP)
	

func input():
	playerVelocity.x = 0
	
	player_controls()
	
	#Are we back on the floor? then reset jumps
	if is_on_floor():
		midAir = false
		hasDoubleJumped = false
		if shouldResetYVel:
			if !Input.is_action_pressed("jump"):
				playerVelocity.y = minGravitiy
				shouldResetYVel = false
	
	if playerVelocity.x == 0:
		action = "Idle"
	else:
		action = "Move"
	
	
	if !is_on_floor():
		midAir = true
		shouldResetYVel = true
		if isGliding:
			playerVelocity.y = glideSpeed
		else:
			if playerVelocity.y < maxFallSpeed:
				playerVelocity += Vector2.DOWN*fallSpeed
				if playerVelocity.y > maxFallSpeed:
					playerVelocity.y = maxFallSpeed
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func player_controls():
	if !AbilityFlags.movementAllowed:
		return
	
	if Input.is_action_pressed("ui_right"):
		playerVelocity += Vector2.RIGHT*moveSpeed
		facing = "Right"
	if Input.is_action_pressed("ui_left"):
		facing = "Left"
		playerVelocity += Vector2.LEFT*moveSpeed
	
	processJump()

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
	if not is_on_floor():
			glide()

#Single jump
func jump():
	playPoof()
	playerVelocity.y = -jumpHeight
	midAir = true
#Midair jump
func doubleJump():
	if AbilityFlags.hasDoubleJump:
		playPoof2()
		playerVelocity.y = -jumpHeight
		hasDoubleJumped = true
#Midair glide
func glide():
	if AbilityFlags.hasGlide && playerVelocity.y > minGravitiy:
		isGliding = Input.is_action_pressed("jump")
	else:
		isGliding = false

func check_growing(delta):
	
	
	if growingCheckTimer < growingCheckDelay:
		growingCheckTimer += delta
		return
	else:
		growingCheckTimer = 0
	
	
	# Get players coords
	var playerPos_world = transform.get_origin()
	# print("Player pos: " + str(playerPos))
	
	# Convert them to x, y in tilemap coords
	var playerPos_map = tileMap.world_to_map(playerPos_world)
	
	# Create surrounding coords
	var coordList_map = []
	coordList_map.append(playerPos_map)
	coordList_map.append(Vector2(playerPos_map.x-1, playerPos_map.y))
	coordList_map.append(Vector2(playerPos_map.x+1, playerPos_map.y))
	coordList_map.append(Vector2(playerPos_map.x, playerPos_map.y+1))
	coordList_map.append(Vector2(playerPos_map.x, playerPos_map.y-1))
	coordList_map.append(Vector2(playerPos_map.x+1, playerPos_map.y-1))
	coordList_map.append(Vector2(playerPos_map.x+1, playerPos_map.y+1))
	coordList_map.append(Vector2(playerPos_map.x-1, playerPos_map.y+1))
	coordList_map.append(Vector2(playerPos_map.x-1, playerPos_map.y-1))
	
	# Is tile free?
	var toPlaceFlowers = []
	for elem in coordList_map:
		if tileMap.get_cell(elem.x, elem.y) == -1:
			toPlaceFlowers.append(elem)
	
	
	for pos in toPlaceFlowers:
		spawn_flower(pos.x, pos.y)
	
	print("Size of list: " + str(len(toPlaceFlowers)))

func spawn_flower(var x, var y):
	# Place finish
	var level_finish_scene = load(flower_path)
	var level_finish_scene_instanced = level_finish_scene.instance()

	# Calculate position
	var sprite_size_vector = level_finish_scene_instanced.get_node("Sprite").get_rect().size
	var world_pos = tileMap.map_to_world(Vector2(x, y))
	var spawn_position = Vector2(world_pos.x + (sprite_size_vector.x /2), world_pos.y + (sprite_size_vector.y /2))
	
	# Set postition
	level_finish_scene_instanced.global_translate(spawn_position)
	
	# Add to level
	flower_root_node.add_child(level_finish_scene_instanced)
