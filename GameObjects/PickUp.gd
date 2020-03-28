extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.get_name() == "Player":
			match name:
				"Glide":
					AbilityFlags.pickedUpGlide = true
					get_parent().remove_child(self)
				"Owl":
					AbilityFlags.pickedUpOwl = true
					get_parent().remove_child(self)
				"DoubleJump":
					AbilityFlags.pickedUpJump = true
					get_parent().remove_child(self)
				"Swap":
					AbilityFlags.pickedUpSwap = true
					get_parent().remove_child(self)
				"Ingredient":
					AbilityFlags.ingredients++
					get_parent().remove_child(self)
