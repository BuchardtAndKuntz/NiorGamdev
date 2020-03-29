extends Node2D

export var canThrow = true
export var ThrowSpeed = 500
export var MaxDistance = 500
export var disappearTime = 3.0
export var SwapTime = 2.0
var SwapTimer
var disappearTimer
var disappear = false
export var decendSpeed = 53
onready var lightSource = $OwlBody/Light2D
onready var animationSprite = $OwlBody/OwlSprite
onready var OwlBody = $OwlBody
var startPos
var velocity = Vector2.ZERO
var isRecalling = false
var parent
var action = "Idle"
var lastAction = "Idle"
var facing = "Right"

# Called when the node enters the scene tree for the first time.
func _ready():
	SwapTimer = 0
	disappearTimer = 0
	parent = get_parent()
	startPos = position
	animationSprite.connect("animation_finished", self, "animFinished")

func animFinished():
	if lastAction=="Vanish":
		print("Vanish finished")
		disappearTimer=0
		resetOwl()

func _physics_process(delta):
	reduceTimer(delta)
	owl_controls()
	MoveOwl()
	

func owl_controls():
	if !AbilityFlags.movementAllowed:
		return
	
	if  Input.is_action_just_pressed("ui_shoot_and_recall"):
		if canThrow:
			throw(get_global_mouse_position())
		elif action!="Vanish":
			playFlaponce()
			isRecalling = false
	if not canThrow && Input.is_action_just_pressed("ui_teleport"):
		swap()

#Reduces the owlswap timer
func reduceTimer(delta):
	SwapTimer+=delta
	if disappear:
		disappearTimer+=delta
	if disappearTimer>disappearTime:
		disappearTimer=0
		action = "Vanish"
		#print("Owl need to be gone", animationSprite.animation)
		
#		resetOwl()
	
	
	
	

func processAnimation():
	#BUG !Bird is flying backwards if we throw it to the left
	match action:
		"Idle":
			if facing == "Right":
				animationSprite.play("RightIdle")
			elif facing == "Left":
				animationSprite.play("LeftIdle")
			playIdle()
		"Fly":
			if facing == "Right":
				animationSprite.play("RightFly")
			if facing == "Left":
				animationSprite.play("LeftFly")
		"Vanish":
			if facing == "Right":
				animationSprite.play("RightVanish")
			elif facing == "Left":
				animationSprite.play("LeftVanish")
			playFoop()
		"Spawn":
			if facing == "Right":
				animationSprite.play("RightSpawn")
			elif facing == "Left":
				animationSprite.play("LeftSpawn")
		"Land":
			if facing == "Right":
				animationSprite.play("RightLanding")
			elif facing == "Left":
				animationSprite.play("LeftLanding")
			playFlaponce()
	animationSprite.set_centered(true)
	lastAction = action
	#print("Bird is facing ", facing)

func playFlaponce():
	SoundController.BirdFlap.set_loop_mode(0)
	$OwlBody/FlapSound.stream = SoundController.BirdFlap
	$OwlBody/FlapSound.play(0.2)

func playPoof():
	$OwlBody/Poofs.stream = SoundController.Poof1
	$OwlBody/Poofs.play(0.2)

func playFoop():
	$OwlBody/Poofs.stream = SoundController.Poof1
	$OwlBody/Poofs.play(0.2)

func playIdle():
	$OwlBody/IdleSound.stream = SoundController.owl_idle
	$OwlBody/IdleSound.play(0.2)

func MoveOwl():
	#If the owl has hit the max distance and is out(visible)
	if ((startPos-OwlBody.get_global_transform().origin).length()>MaxDistance || OwlBody.is_on_wall() || OwlBody.is_on_ceiling()) && visible==true :
		if not OwlBody.is_on_floor():
			velocity = Vector2(0,decendSpeed)
			action = "Land"
		else:
			velocity = Vector2.ZERO
			action = "Idle"
	if OwlBody.is_on_floor() && not disappear:
			action = "Idle"
			velocity.x = 0
			disappearTimer = 0
			disappear=true
	
	if(isRecalling):
		if((parent.get_global_transform().origin -OwlBody.get_global_transform().origin).length()<50):
			resetOwl()
		else:
			velocity = recall()
			action = "Fly"
			
		
	#print("Bird speed Is ", velocity.x)
	if velocity.x >= 0: 
		facing = "Right"
		if action == "Spawn" && !animationSprite.is_playing():
			action = "Fly"
	elif velocity.x < 0:
		facing = "Left"
		if action == "Spawn" && !animationSprite.is_playing():
			action = "Fly"
	

	
	processAnimation()
	
	OwlBody.move_and_slide(velocity, Vector2.UP)

func throw(destination):
	if canThrow && AbilityFlags.canThrowOwl:
		action = "Spawn"
		playFlaponce()
		visible = true
		lightSource.enabled = true
		disappear = false
		canThrow = false
		var currentPos = OwlBody.get_global_transform().origin
		OwlBody.set_as_toplevel(true)
		OwlBody.position = currentPos
		startPos = get_global_transform().origin
		velocity = (destination-startPos).normalized()*ThrowSpeed

#Swaps the position of the player and the owl
func swap():
	#Checks if the swap cooldown is over
	if AbilityFlags.hasOwlSwitch:
		if SwapTimer>SwapTime:
			SwapTimer = 0
			var oldPPos = parent.position
			var oldOPos = OwlBody.position
			parent.position = oldOPos
			OwlBody.position = oldPPos
			resetOwl()

#Resets the owl to the starting pos and roots it to the player pos
func resetOwl():
	visible = false
	canThrow = true
	isRecalling = false
	disappear = false
	lightSource.enabled = false
	OwlBody.set_as_toplevel(false)
	animationSprite.play("RightIdle")
	action = "Idle"
	velocity = Vector2.ZERO
	OwlBody.position = Vector2.ZERO

#Recalls the owl to the player pos
func recall():
	return ( parent.get_global_transform().origin -OwlBody.get_global_transform().origin ).normalized()*ThrowSpeed
