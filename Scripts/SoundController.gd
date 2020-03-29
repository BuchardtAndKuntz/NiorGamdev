extends Node

var Poof1
var Poof2
var Jump1
var Jump2
var Jump3
var Grab
var Fanfare
var bgSFX
var BirdFlap
var lightFire
var fireCrackle

func _ready():
	Poof1 = load("res://Sounds/Poof1.wav")
	Poof2 = load("res://Sounds/Poof2.wav")
	Grab = load("res://Sounds/Grab1.wav")
	Fanfare = load("res://Sounds/abilityfanfare.wav")
	bgSFX = load("res://Sounds/baggroundSFX.wav")
	BirdFlap = load("res://Sounds/Bird Wing Flap.wav")
	
	lightFire = load("res://Sounds/lightFire.wav")
	fireCrackle = load("res://Sounds/fireCrackle.wav")
	Jump1 = load("res://Sounds/jumpSound.wav")
	Jump2 = load("res://Sounds/jump2Sound.wav")
	Jump3 = load("res://Sounds/jump3Sound.wav")
