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
	if AbilityFlags.WIN:
		winScreen()
	if AbilityFlags.pickedUpOwl:
		owlPicked()
	if AbilityFlags.pickedUpGlide:
		glidePicked()
	if AbilityFlags.pickedUpJump:
		doubleJumpPicked()
	if AbilityFlags.pickedUpSwap:
		swapPicked()
	
	if shown:
		AbilityFlags.movementAllowed = false
		if Input.is_action_just_pressed("ui_accept") :
			AbilityFlags.movementAllowed = true
			AbilityFlags.WIN = false
			hideAll()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func winScreen():
	$WinScreen.show()
	shown = true

func hideAll():
	jump.hide()
	glide.hide()
	swap.hide()
	owl.hide()
	$WinScreen.hide()
	shown = false

func doubleJumpPicked():
	jump.show()
	AbilityFlags.pickedUpJump = false
	AbilityFlags.hasDoubleJump = true
	shown = true

func glidePicked():
	glide.show()
	AbilityFlags.pickedUpGlide = false
	AbilityFlags.hasGlide = true
	shown = true

func swapPicked():
	swap.show()
	AbilityFlags.pickedUpSwap = false
	AbilityFlags.hasOwlSwitch = true
	shown = true

func owlPicked():
	owl.show()
	AbilityFlags.pickedUpOwl = false
	AbilityFlags.canThrowOwl = true
	shown = true
