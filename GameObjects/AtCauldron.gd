extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var time = 5
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if AbilityFlags.WIN:
		timer = 0
	else:
		timer+=delta
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(timer)
		print(AbilityFlags.WIN)
		if body.get_name() == "Player":
			if timer>time:
				AbilityFlags.WIN = true
