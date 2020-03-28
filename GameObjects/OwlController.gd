extends Node2D

export var ThrowAble = true
export var ThrowSpeed = 500
export var MaxDistance = 500

onready var OwlBody = $OwlBody
var startPos
var velocity = Vector2.ZERO
var isRecalling
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	startPos = position
	pass # Replace with function body.


func _physics_process(delta):
	if  Input.is_action_just_pressed("ui_shoot"):
		throw(get_global_mouse_position())
	elif  Input.is_action_just_pressed("recall"):
		isRecalling = true
	MoveOwl()
	

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
	if ThrowAble:
		ThrowAble = false
		var currentPos = OwlBody.get_global_transform().origin
		OwlBody.set_as_toplevel(true)
		OwlBody.position = currentPos
		startPos = get_global_transform().origin
		velocity = (destination-startPos).normalized()*ThrowSpeed
		#Get set startpos
		#move and slide towards direction of mouse
		#if collision owl stays at collision spot
	#if trowable

func resetOwl():
	ThrowAble = true
	isRecalling = false
	OwlBody.set_as_toplevel(false)
	velocity = Vector2.ZERO
	OwlBody.position = Vector2.ZERO

func recall():
	#Recall 
	return ( parent.get_global_transform().origin -OwlBody.get_global_transform().origin ).normalized()*ThrowSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
