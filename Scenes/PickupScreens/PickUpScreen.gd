extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var jump = $DoubleJump
onready var glide = $Glide
onready var swap = $Swap
onready var owl = $ThrowOwl
var shown = false



func _process(delta):
	if AbilityFlags.pickedUpOwl:
		owlPicked()
	
	if shown && Input.is_action_just_released("ui_accept") :
		hideAll()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hideAll():
	jump.hide()
	glide.hide()
	swap.hide()
	owl.hide()

func doubleJumpPicked():
	jump.show()
	shown = true

func glidePicked():
	glide.show()
	shown = true

func swapPicked():
	swap.show()
	shown = true

func owlPicked():
	owl.show()
	AbilityFlags.pickedUpOwl = false
	AbilityFlags.canThrowOwl = true
	shown = true
