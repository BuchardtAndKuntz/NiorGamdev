extends Node

var Poof1
var Poof2
var Grab
var Fanfare
var bgSFX
var BirdFlap

func _ready():
	Poof1 = load("res://Sounds/Poof1.wav")
	Poof2 = load("res://Sounds/Poof2.wav")
	Grab = load("res://Sounds/Grab1.wav")
	Fanfare = load("res://Sounds/abilityfanfare.wav")
	bgSFX = load("res://Sounds/baggroundSFX.wav")
	BirdFlap = load("res://Sounds/Bird Wing Flap.wav")
