extends Node2D


var underflow = 2
var overflow = 3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	overflow = 5
	underflow = 3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _conflictMaker():
	overflow = overflow + 1
	print("Test")
