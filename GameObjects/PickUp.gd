extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.get_name() == "Player":
			match name:
				"Glide":
					AbilityFlags.pickedUpGlide = true
					body.playFanfare()
					get_parent().remove_child(self)
				"Owl":
					AbilityFlags.pickedUpOwl = true
					body.playFanfare()
					get_parent().remove_child(self)
				"DoubleJump":
					AbilityFlags.pickedUpJump = true
					body.playFanfare()
					get_parent().remove_child(self)
				"Swap":
					AbilityFlags.pickedUpSwap = true
					body.playFanfare()
					get_parent().remove_child(self)
				"Ingredient":
					AbilityFlags.ingredients = AbilityFlags.ingredients+1
					body.playGrab()
					get_parent().remove_child(self)
