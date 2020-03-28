extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	print(bodies)
	for body in bodies:
		if body.get_name() == "Player":
			AbilityFlags.pickedUpOwl = true
			get_parent().remove_child(self)
