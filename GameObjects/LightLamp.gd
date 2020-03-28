extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var on = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if on:
		return
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body.get_name())
		if (body.get_name() == "Player" || body.get_name() == "OwlBody"):
			lightLamp()


func lightLamp():
	on = true
	get_parent().get_node("Off").visible=false
	get_parent().get_node("On").visible=true
	get_parent().get_node("Light2D").enabled = true
	
