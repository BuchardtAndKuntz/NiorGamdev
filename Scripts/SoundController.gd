extends Node

var Poof1
var Poof2
var Grab
var Fanfare
var bgSFX
var BirdFlap
var lightFire
var fireCrackle
var owl_idle

func _ready():
	Poof1 = load("res://Sounds/Poof1.wav")
	Poof2 = load("res://Sounds/Poof2.wav")
	Grab = load("res://Sounds/Grab1.wav")
	Fanfare = load("res://Sounds/abilityfanfare.wav")
	bgSFX = load("res://Sounds/baggroundSFX.wav")
	BirdFlap = load("res://Sounds/Bird Wing Flap.wav")
	owl_idle = load("res://Sounds/breviceps__owl-hoot.wav")
	
	lightFire = load("res://Sounds/lightFire.wav")
	fireCrackle = load("res://Sounds/fireCrackle.wav")
