extends Node2D

export var canThrow = true
export var ThrowSpeed = 500
export var MaxDistance = 500
export var SwapTimer = 2.0
var timer

onready var OwlBody = $OwlBody
var startPos
var velocity = Vector2.ZERO
var isRecalling
var parent


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	parent = get_parent()
	startPos = position
	pass # Replace with function body.


func _physics_process(delta):
	reduceTimer(delta)
	if  Input.is_action_just_pressed("ui_shoot"):
		throw(get_global_mouse_position())
	elif  Input.is_action_just_pressed("ui_recall"):
		isRecalling = true
	if not canThrow && Input.is_action_just_pressed("ui_home"):
		swap()
		
	MoveOwl()
	

#Reduces the owlswap timer
func reduceTimer(delta):
	timer+=delta

func MoveOwl():
	if (startPos-OwlBody.get_global_transform().origin).length()>MaxDistance:
		velocity = Vector2.ZERO
	
	if(isRecalling):
		if((parent.get_global_transform().origin -OwlBody.get_global_transform().origin).length()<50):
			resetOwl()
		else:
			velocity = recall()
		
	
	OwlBody.move_and_slide(velocity, Vector2.UP)

func throw(destination):
	if canThrow && AbilityFlags.canThrowOwl:
		canThrow = false
		var currentPos = OwlBody.get_global_transform().origin
		OwlBody.set_as_toplevel(true)
		OwlBody.position = currentPos
		startPos = get_global_transform().origin
		velocity = (destination-startPos).normalized()*ThrowSpeed
#Swaps the position of the player and the owl
func swap():
	#Checks if the swap cooldown is over
	if timer>SwapTimer:
		timer = 0
		var oldPPos = parent.position
		var oldOPos = OwlBody.position
		parent.position = oldOPos
		OwlBody.position = oldPPos

#Resets the owl to the starting pos and roots it to the player pos
func resetOwl():
	canThrow = true
	isRecalling = false
	OwlBody.set_as_toplevel(false)
	velocity = Vector2.ZERO
	OwlBody.position = Vector2.ZERO

#Recalls the owl to the player pos
func recall():
	return ( parent.get_global_transform().origin -OwlBody.get_global_transform().origin ).normalized()*ThrowSpeed
