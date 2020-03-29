extends Node2D

onready var player = get_node("Player")
var on_initial_cutscene = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if on_initial_cutscene:
		AbilityFlags.movementAllowed = false
		initial_drop_check()
	
func initial_drop_check():
	if player != null:
		#print("Mid air: " + str(player.midAir))
		if !player.midAir:
			AbilityFlags.movementAllowed = true
			on_initial_cutscene = false
