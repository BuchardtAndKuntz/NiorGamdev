extends Node2D

export var canThrow = true
export var ThrowSpeed = 500
export var MaxDistance = 500
export var disappearTime = 10.0
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
var isRecalling
var parent
var action = "Idle"
var facing = "Right"

# Called when the node enters the scene tree for the first time.
func _ready():
	SwapTimer = 0
	disappearTimer = 0
	parent = get_parent()
	startPos = position
	pass # Replace with function body.


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
		else:
			isRecalling = true	
	if not canThrow && Input.is_action_just_pressed("ui_teleport"):
		swap()

#Reduces the owlswap timer
func reduceTimer(delta):
	SwapTimer+=delta
	if disappear:
		disappearTimer+=delta
	if disappearTimer>disappearTime:
		disappearTimer=0
		resetOwl()
	
	
	
	

func processAnimation():
	match action:
		"Idle":
			if facing == "Right":
				animationSprite.play("RightIdle")
			elif facing == "Left":
				animationSprite.play("LeftIdle")


func MoveOwl():
	#If the owl has hit the max distance and is out(visible)
	if ((startPos-OwlBody.get_global_transform().origin).length()>MaxDistance || OwlBody.is_on_wall() || OwlBody.is_on_ceiling()) && visible==true :
		if not OwlBody.is_on_floor():
			velocity = Vector2(0,decendSpeed)
		else:
			velocity = Vector2.ZERO
	if OwlBody.is_on_floor() && not disappear:
			disappearTimer = 0
			disappear=true
			
	if(isRecalling):
		if((parent.get_global_transform().origin -OwlBody.get_global_transform().origin).length()<50):
			resetOwl()
		else:
			velocity = recall()
		
	
	if velocity.x >= 0: 
		facing = "Right"
	else:
		facing = "Left"
	processAnimation()
	
	OwlBody.move_and_slide(velocity, Vector2.UP)

func throw(destination):
	if canThrow && AbilityFlags.canThrowOwl:
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
	velocity = Vector2.ZERO
	OwlBody.position = Vector2.ZERO

#Recalls the owl to the player pos
func recall():
	return ( parent.get_global_transform().origin -OwlBody.get_global_transform().origin ).normalized()*ThrowSpeed
