extends Node2D

export var ThrowAble = true
export var ThrowSpeed = 500
export var MaxDistance = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var OwlBody = $OwlBody
var startPos
var currentPos
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = position
	pass # Replace with function body.


func _physics_process(delta):
	if  Input.is_action_just_pressed("ui_shoot"):
		throw(startPos+(Vector2.RIGHT*MaxDistance))
	MoveOwl()
	

func MoveOwl():
	OwlBody.move_and_slide(velocity, Vector2.UP)

func throw(destination):
	if ThrowAble:
		startPos = position
		velocity = (destination-startPos).normalized()*ThrowSpeed
		#Get set startpos
		#move and slide towards direction of mouse
		#if collision owl stays at collision spot
	#if trowable

func recall():
	#recalls owl 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
